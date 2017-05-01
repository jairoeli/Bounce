//
//  AuthService.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import SafariServices
import URLNavigator
import Alamofire
import KeychainAccess
import RxSwift

protocol AuthServiceType {
  var currentAccessToken: AccessToken? { get }

  /// Start OAuth authorization process.
  ///
  /// - returns: An Observable of `AccessToken` instance.
  func authorize() -> Observable<Void>

  /// Call this method when redirected from OAuth process to request access token.
  ///
  /// - parameter code: `code` from redirected url.
  func callback(code: String)

  func logout()
}

final class AuthService: BaseService, AuthServiceType {

  fileprivate let clientID = "869d59f0d22a730c9af9d9ccb00c7da03f5cbfd5eb3af36dc975c2b41f45a5ae"
  fileprivate let clientSecret = "be6df695bf0be8c51cc554d97e586cc97c3a607777a7a72fb7756a6ac804e346"

  fileprivate var currentViewController: UIViewController?
  fileprivate let callbackSubject = PublishSubject<String>()

  fileprivate let keychain = Keychain(service: "jed.Bounce")
  private(set) var currentAccessToken: AccessToken?

  override init(provider: ServiceProviderType) {
    super.init(provider: provider)
    self.currentAccessToken = self.loadAccessToken()
    log.debug("currentAccessToken exists: \(self.currentAccessToken != nil)")
  }

  func authorize() -> Observable<Void> {
    let parameters: [String: String] = [
      "client_id": self.clientID,
      "scope": "public+write+comment+upload"
      ]
    let parameterString = parameters.map { "\($0)=\($1)" }.joined(separator: "&")
    let url = URL(string: "https://dribbble.com/oauth/authorize?\(parameterString)")!

    let safariViewController = SFSafariViewController(url: url)
    let navigationController = UINavigationController(rootViewController: safariViewController)
    navigationController.isNavigationBarHidden = true
    Navigator.present(navigationController)
    self.currentViewController = navigationController

    return self.callbackSubject
      .flatMap(self.accessToken)
      .do(onNext: { [weak self] accessToken in
        try self?.saveAccessToken(accessToken)
        self?.currentAccessToken = accessToken
      })
      .map { _ in Void() }
  }

  func callback(code: String) {
    self.callbackSubject.onNext(code)
    self.currentViewController?.dismiss(animated: true, completion: nil)
    self.currentViewController = nil
  }

  func logout() {
    self.currentAccessToken = nil
    self.deleteAccessToken()
  }

  fileprivate func accessToken(code: String) -> Observable<AccessToken> {
    let urlString = "https://dribbble.com/oauth/token"
    let parameters: Parameters = [
      "client_id": self.clientID,
      "client_secret": self.clientSecret,
      "code": code
    ]
    return Observable.create { observer in
      let request = Alamofire
        .request(urlString, method: .post, parameters: parameters)
        .responseString { response in
          switch response.result {
          case .success(let jsonString):
            do {
              let accessToken = try AccessToken(JSONString: jsonString)
              observer.onNext(accessToken)
              observer.onCompleted()
            } catch let error {
              observer.onError(error)
            }

          case .failure(let error):
            observer.onError(error)
          }
      }

      return Disposables.create { request.cancel() }
    }

  }

  fileprivate func saveAccessToken(_ accessToken: AccessToken) throws {
    try self.keychain.set(accessToken.accessToken, key: "access_token")
    try self.keychain.set(accessToken.tokenType, key: "token_type")
    try self.keychain.set(accessToken.scope, key: "scope")
  }

  fileprivate func loadAccessToken() -> AccessToken? {
    guard let accessToken = self.keychain["access_token"],
      let tokenType = self.keychain["token_type"],
      let scope = self.keychain["scope"] else { return nil }

    return AccessToken(accessToken: accessToken, tokenType: tokenType, scope: scope)
  }

  fileprivate func deleteAccessToken() {
    try? self.keychain.remove("access_token")
    try? self.keychain.remove("token_type")
    try? self.keychain.remove("scope")
  }

}
