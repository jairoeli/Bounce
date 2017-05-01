//
//  AppDelegate.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import CGFloatLiteral
import ManualLayout
import RxGesture
import RxOptional
import RxReusable
import SnapKit
import SwiftyColor
import SwiftyImage
import Then
import UITextView_Placeholder
import URLNavigator
import Kingfisher
import WebLinking
import Immutable

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
    self.configureAppearance()

    let window = UIWindow(frame: UIScreen.main.bounds)
    window.backgroundColor = .white
    window.makeKeyAndVisible()

    let serviceProvider: ServiceProviderType = ServiceProvider()
    URLNavigationMap.initialize(provider: serviceProvider)

    let splashViewModel = SplashViewModel(provider: serviceProvider)
    let splashViewController = SplashViewController(viewModel: splashViewModel)
    window.rootViewController = splashViewController

    self.window = window
    return true
  }

  func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {

    if Navigator.open(url) { return true }

    if Navigator.present(url, wrap: true) != nil { return true }

    return false
  }

  // MARK: - Appearance

  private func configureAppearance() {
    UINavigationBar.appearance().barTintColor = .white
    UINavigationBar.appearance().tintColor = .black
    UINavigationBar.appearance().isTranslucent = false
  }

  // MARK: - Presenting

  func presentLoginScreen(viewModel: LoginViewModelType) {
    let viewController = LoginViewController(viewModel: viewModel)
    self.window?.rootViewController = viewController
  }

  func presentMainScreen(viewModel: MainTabBarViewModelType) {
    let mainTabBarController = MainTabBarController(viewModel: viewModel)
    self.window?.rootViewController = mainTabBarController
  }

}
