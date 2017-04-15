//
//  AppDelegate.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import CGFloatLiteral
import ManualLayout
import RxOptional
import SnapKit
import SwiftyColor
import SwiftyImage
import Then
import UITextView_Placeholder
import URLNavigator
import Kingfisher
import WebLinking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  // MARK: - Property
  
  class var shared: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  // MARK: - UI

  var window: UIWindow?
  
  // MARK: - UIApplicationDelegate

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()
    
    let serviceProvider: ServiceProviderType = ServiceProvider()
    URLNavigationMap.initialize(provider: serviceProvider)
    
    let splashViewModel = SplashViewModel(provider: serviceProvider)
    let splashViewController = SplashViewController(viewModel: splashViewModel)
    window.rootViewController = splashViewController
    
    self.window = window
    self.configureAppearance()
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
    if Navigator.open(url) { return true }
    
    if Navigator.present(url, wrap: true) != nil { return true }
    
    return false
  }
  
  // MARK: - Appearance
  
  private func configureAppearance() {
    let navigationBarBackgroundImage = UIImage.resizable().color(.jet).image
    UINavigationBar.appearance().setBackgroundImage(navigationBarBackgroundImage, for: .default)
    UINavigationBar.appearance().shadowImage = UIImage()
    UINavigationBar.appearance().barStyle = .black
  }
  
  // MARK: - Presenting
  
  func presentLoginScreen(viewModel: LoginViewModelType) {
    let viewController = LoginViewController(viewModel: viewModel)
    self.window?.rootViewController = viewController
  }

  func presentMainScreen(viewModel: ShotFeedViewModelType) {
    let viewController = ShotFeedViewController(viewModel: viewModel)
    let navigationController = UINavigationController(rootViewController: viewController)
    self.window?.rootViewController = navigationController
  }

}
