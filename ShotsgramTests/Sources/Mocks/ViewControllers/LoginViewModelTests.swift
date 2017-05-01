//
//  LoginViewModelTests.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import XCTest
import RxCocoa
import RxExpect
import RxSwift
import RxTest

@testable import Bounce

final class LoginViewModelTests: XCTestCase {

  func testLoginButtonIsHidden() {

    RxExpect("It should make login button hidden when login button tap") { test in
      // Enviroment
      let provider = MockServiceProvider()

      provider.authService = MockAuthService(provider: provider).then {
        $0.authorizeClosure = { Observable.just(Void()) }
      }

      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { Observable.just(Void()) }
      }

      let viewModel = LoginViewModel(provider: provider)

      // Input
      test.input(viewModel.login, [next(100, Void())])
      viewModel.presentMainScreen.subscribe().disposed(by: test.disposeBag)

      // Output
      test.assert(viewModel.isLoading)
        .filterNext()
        .equal([
            false, // initial
            true, // while loggin in
            false // finish
          ])
    }

  }

  func testPresentMainScreen() {
    RxExpect("It should present main screen when authorize() and fetchMe() succeeds") { test in
      // Enviroment
      let provider = MockServiceProvider()
      provider.authService = MockAuthService(provider: provider).then {
        $0.authorizeClosure = { Observable.just(Void()) }
      }

      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { Observable.just(Void()) }
      }

      let viewModel = LoginViewModel(provider: provider)

      // Input
      test.input(viewModel.login, [next(100, Void())])

      // Output
      test.assert(viewModel.presentMainScreen)
        .filterNext()
        .not()
        .isEmpty()
    }

    RxExpect("it should not present main screen when authorize() fails") { test in
      // Environment
      let provider = MockServiceProvider()
      provider.authService = MockAuthService(provider: provider).then {
        $0.authorizeClosure = { .error(MockError()) }
      }
      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { Observable.just(Void()) }
      }
      let viewModel = LoginViewModel(provider: provider)

      // Input
      test.input(viewModel.login, [next(100, Void()) ])

      // Output
      test.assert(viewModel.presentMainScreen)
        .filterNext()
        .isEmpty()
    }

    RxExpect("it should not present main screen when fetchMe() fails") { test in
      // Environment
      let provider = MockServiceProvider()
      provider.authService = MockAuthService(provider: provider).then {
        $0.authorizeClosure = { .just(Void()) }
      }
      provider.userService = MockUserService(provider: provider).then {
        $0.fetchMeClosure = { .error(MockError()) }
      }
      let viewModel = LoginViewModel(provider: provider)

      // Input
      test.input(viewModel.login, [next(100, Void())])

      // Output
      test.assert(viewModel.presentMainScreen)
        .filterNext()
        .isEmpty()
    }

  }

}
