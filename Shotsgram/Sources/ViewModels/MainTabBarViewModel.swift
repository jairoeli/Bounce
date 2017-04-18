//
//  MainTabBarViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol MainTabBarViewModelType {
  // Output
  var shotFeedViewModel: Driver<ShotFeedViewModelType> { get }
  var settingsViewModel: Driver<SettingsViewModelType> { get }
}

final class MainTabBarViewModel: MainTabBarViewModelType {
  
  // MARK: - Output
  
  let shotFeedViewModel: Driver<ShotFeedViewModelType>
  let settingsViewModel: Driver<SettingsViewModelType>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType) {
    self.shotFeedViewModel = .just(ShotFeedViewModel(provider: provider))
    self.settingsViewModel = .just(SettingsViewModel(provider: provider))
  }
  
}
