//
//  MainTabBarController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class MainTabBarController: UITabBarController {
  
  // MARK: - Property
  
  fileprivate let disposeBag = DisposeBag()
  
  // MARK: - Initializing
  
  init(viewModel: MainTabBarViewModelType) {
    super.init(nibName: nil, bundle: nil)
    self.tabBar.barTintColor = .black
    self.tabBar.isTranslucent = false
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuring
  
  private func configure(viewModel: MainTabBarViewModelType) {
    // Output
    let shotFeedNavigationController: Driver<UINavigationController> = viewModel.shotFeedViewModel
      .map { ShotFeedViewController(viewModel: $0) }
      .map { UINavigationController(rootViewController: $0) }
    
    let settingsNavigationController: Driver<UINavigationController> = viewModel.settingsViewModel
      .map { SettingsViewController(viewModel: $0) }
      .map { UINavigationController(rootViewController: $0) }
    
    let navigationControllers: [Driver<UINavigationController>] = [shotFeedNavigationController, settingsNavigationController]
    
    Driver.combineLatest(navigationControllers) { $0 }
      .drive(onNext: { [weak self] navigationControllers in
        self?.viewControllers = navigationControllers
      })
      .disposed(by: self.disposeBag)
  }
  
}
