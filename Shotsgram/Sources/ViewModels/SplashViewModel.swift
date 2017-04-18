//
//  SplashViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol SplashViewModelType {
  // Input
  var checkIfAuthenticated: PublishSubject<Void> { get }
  
  // Output
  var presentLoginScreen: Observable<LoginViewModelType> { get }
  var presentMainScreen: Observable<MainTabBarViewModelType> { get }
}


// MARK: - ViewModel
final class SplashViewModel: SplashViewModelType {
  
  // MARK: Input
  let checkIfAuthenticated: PublishSubject<Void> = .init()
  
  
  // MARK: Output
  let presentLoginScreen: Observable<LoginViewModelType>
  let presentMainScreen: Observable<MainTabBarViewModelType>
  
  
  // MARK: Initializing
  init(provider: ServiceProviderType) {
    let isAuthenticated = self.checkIfAuthenticated
      .flatMap { provider.userService.fetchMe() }
      .map { true }
      .catchError { _ in .just(false) }
      .shareReplay(1)
    
    self.presentLoginScreen = isAuthenticated
      .filter { !$0 }
      .map { _ in LoginViewModel(provider: provider) }
    
    self.presentMainScreen = isAuthenticated
      .filter { $0 }
      .map { _ in MainTabBarViewModel(provider: provider) }
  }
  
}
