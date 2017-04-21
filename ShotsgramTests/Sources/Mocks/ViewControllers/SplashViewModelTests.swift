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
    RxExpect("it should present login screen when failed to fetch me") { test in
      
      let provider = MockServiceProvider()
      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { Observable.error(MockError()) }
      }
      
      let viewModel = SplashViewModel(provider: provider)
      test.input(viewModel.checkIfAuthenticated, [next(100, Void()),])
      test.assert(viewModel.presentLoginScreen.map(true))
        .filterNext()
        .equal([true])
    }
  }
  
  func testPresentMainScreen() {
    
    RxExpect("It should present main screen when succceed to fetch me") { test in
      let provider = MockServiceProvider()
      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { .just(Void()) }
      }
      
      let viewModel = SplashViewModel(provider: provider)
      test.input(viewModel.checkIfAuthenticated, [ next(100, Void()),])
      
      test.assert(viewModel.presentMainScreen.map(true))
        .filterNext()
        .equal([true])
      
    }
    
  }
  
}
