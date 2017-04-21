//
//  SplashViewModelTests.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import XCTest
import RxCocoa
import RxExpect
import RxSwift
import RxTest

@testable import Shotsgram

final class SplashViewModelTests: XCTestCase {
  
  func testPresentLoginScreen() {
    RxExpect("it should present login screen when not authenticated") { test in
      let provider = MockServiceProvider()
      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { Observable.error(MockError()) }
      }
      let reactor = SplashViewReactor(provider: provider)
      test.input(reactor.checkIfAuthenticated, [
        next(100, Void()),
        ])
      test.assert(reactor.presentLoginScreen.map(true))
        .filterNext()
        .equal([true])
    }
  }
  
}
