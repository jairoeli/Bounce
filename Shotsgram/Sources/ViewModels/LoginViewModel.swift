//
//  LoginViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift
import RxSwiftUtilities

protocol LoginViewModelType {
  // Input
  var login: PublishSubject<Void> { get }
  
  // Output
  var loginButtonEnabled: Driver<Bool> { get }
  var presentMainScreen: Observable<ShotFeedViewModelType> { get }
}

final class LoginViewModel: LoginViewModelType {
  
  // MARK: Input
  let login: PublishSubject<Void> = .init()
  
  
  // MARK: Output
  let loginButtonEnabled: Driver<Bool>
  let presentMainScreen: Observable<ShotFeedViewModelType>
  
  // MARK: Initializing
  init(provider: ServiceProviderType) {
    let isLoading = ActivityIndicator()
    
    self.loginButtonEnabled = isLoading.map { !$0 }.asDriver()
    self.presentMainScreen = self.login
      .flatMap { provider.authService.authorize().trackActivity(isLoading) }
      .flatMap { provider.userService.fetchMe() }
      .map { ShotFeedViewModel(provider: provider) }
  }
  
}


