//
//  MockAuthService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift
import Then

@testable import Shotsgram

final class MockAuthService: BaseService, AuthServiceType, Then {
  var currentAccessToken: AccessToken? {
    return nil
  }
  
  func authorize() -> Observable<Void> {
    return .never()
  }
  
  func callback(code: String) {
  }
  
  func logout() {
  }
}
