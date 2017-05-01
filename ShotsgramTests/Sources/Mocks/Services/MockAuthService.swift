//
//  MockAuthService.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift
import Then

@testable import Bounce

final class MockAuthService: BaseService, AuthServiceType, Then {
  var currentAccessToken: AccessToken? { return nil }

  var authorizeClosure: () -> Observable<Void> = { return .never() }
  func authorize() -> Observable<Void> {
    return self.authorizeClosure()
  }

  func callback(code: String) {}

  func logout() {}

}
