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
  var isLoading: Driver<Bool> { get }
  var presentMainScreen: Observable<MainTabBarViewModelType> { get }
}

final class LoginViewModel: LoginViewModelType {
  
  // MARK: Input
  let login: PublishSubject<Void> = .init()
  
  
  // MARK: Output
  let isLoading: Driver<Bool>
  let presentMainScreen: Observable<MainTabBarViewModelType>
  
  // MARK: Initializing
  
  init(provider: ServiceProviderType) {
    let isLoading = ActivityIndicator()
    self.isLoading = isLoading.asDriver()
    self.presentMainScreen = self.login
      .filter(!isLoading)
      .flatMap { provider.authService.authorize().trackActivity(isLoading) }
      .flatMap { provider.userService.fetchMe() }
      .map { MainTabBarViewModel(provider: provider) }
  }
  
}


