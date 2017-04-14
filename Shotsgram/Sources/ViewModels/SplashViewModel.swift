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
  var viewDidAppear: PublishSubject<Void> { get }
  var presentLoginScreen: Observable<LoginViewModelType> { get }
  var presentMainScreen: Observable<ShotFeedViewModelType> { get }
}


// MARK: - ViewModel
final class SplashViewModel: SplashViewModelType {
  
  // MARK: Input
  let viewDidAppear: PublishSubject<Void> = .init()
  
  
  // MARK: Output
  let presentLoginScreen: Observable<LoginViewModelType>
  let presentMainScreen: Observable<ShotFeedViewModelType>
  
  
  // MARK: Initializing
  init(provider: ServiceProviderType) {
    self.presentLoginScreen = self.viewDidAppear
      .map { LoginViewModel(provider: provider) }
    self.presentMainScreen = .never()
  }
  
}
