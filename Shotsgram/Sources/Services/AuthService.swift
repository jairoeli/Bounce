//
//  AuthService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import SafariServices
import URLNavigator
import Alamofire
import RxSwift

protocol AuthServiceType {
  var accessToken: AccessToken? { get }
  
  /// Start OAuth authorization process.
  ///
  /// - returns: An Observable of `AccessToken` instance.
  func authorize() -> Observable<AccessToken>
  
  /// Call this method when redirected from OAuth process to request access token.
  ///
  /// - parameter code: `code` from redirected url.
  func callback(code: String)
}

final class AuthService: BaseService, AuthServiceType {
  
  fileprivate let clientID = "869d59f0d22a730c9af9d9ccb00c7da03f5cbfd5eb3af36dc975c2b41f45a5ae"
  fileprivate let clientSecret = "be6df695bf0be8c51cc554d97e586cc97c3a607777a7a72fb7756a6ac804e346"
  
  fileprivate var currentViewController: UIViewController?
  fileprivate let callbackSubject = PublishSubject<String>()
  private(set) var accessToken: AccessToken?
  
  func authorize() -> Observable<AccessToken> {
    let url = URL(string: "https://dribbble.com/oauth/authorize?client_id=\(self.clientID)")!
    
    let safariViewController = SFSafariViewController(url: url)
    let navigationController = UINavigationController(rootViewController: safariViewController)
    navigationController.isNavigationBarHidden = true
    Navigator.present(navigationController)
    self.currentViewController = navigationController
    
    return self.callbackSubject.flatMap(self.accessToken)
  }
  
  func callback(code: String) {
    self.callbackSubject.onNext(code)
    self.currentViewController?.dismiss(animated: true, completion: nil)
    self.currentViewController = nil
  }
  
  fileprivate func accessToken(code: String) -> Observable<AccessToken> {
    let urlString = "https://dribbble.com/oauth/token"
    let parameters: Parameters = [
      "client_id": self.clientID,
      "client_secret": self.clientSecret,
      "code": code
    ]
    return Observable.create { [weak self] observer in
      let request = Alamofire
        .request(urlString, method: .post, parameters: parameters)
        .responseString { response in
          switch response.result {
          case .success(let jsonString):
            do {
              let accessToken = try AccessToken(JSONString: jsonString)
              self?.accessToken = accessToken
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
  
}
