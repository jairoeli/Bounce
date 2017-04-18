//
//  SettingsViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

enum LogoutAlertActionItem {
  case logout
  case cancel
}

protocol SettingsViewModelType: class {
  // input
  var tableViewDidSelectItem: PublishSubject<SettingsViewSectionItem> { get }
  var logoutAlertDidSelectActionItem: PublishSubject<LogoutAlertActionItem> { get }
  
  // output
  var tableViewSections: Driver<[SettingsViewSection]> { get }
  var presentOpenSourceViewController: Observable<Void> { get }
  var presentLogoutAlert: Observable<[LogoutAlertActionItem]> { get }
  var presentLoginScreen: Observable<LoginViewModelType> { get }
}

final class SettingsViewModel: SettingsViewModelType {
  
  // MARK: - Input
  
  let tableViewDidSelectItem: PublishSubject<SettingsViewSectionItem> = .init()
  var logoutAlertDidSelectActionItem: PublishSubject<LogoutAlertActionItem> = .init()
  
  // MARK: - Output
  
  let tableViewSections: Driver<[SettingsViewSection]>
  let presentOpenSourceViewController: Observable<Void>
  let presentLogoutAlert: Observable<[LogoutAlertActionItem]>
  let presentLoginScreen: Observable<LoginViewModelType>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType) {
    let cls = SettingsViewModel.self
    
    let sections = [cls.aboutSection(provider: provider), cls.logoutSection(provider: provider)]
    
    self.tableViewSections = Observable
      .combineLatest(sections) { $0 }
      .asDriver(onErrorJustReturn: [])
    
    self.presentOpenSourceViewController = self.tableViewDidSelectItem
      .filter { sectionItem -> Bool in
        if case .openSource = sectionItem {
          return true
        } else {
          return false
        }
    }
    .mapVoid()
    
    self.presentLogoutAlert = self.tableViewDidSelectItem
      .filter { sectionItem -> Bool in
        if case .logout = sectionItem {
          return true
        } else {
          return false
        }
    }
      .map { _ in [.logout, .cancel] }
    
    self.presentLoginScreen = self.logoutAlertDidSelectActionItem
      .filter { $0 == .logout }
      .do(onNext: { _ in provider.authService.logout() })
      .map { _ in LoginViewModel(provider: provider) }
    
  }
  
  // MARK: - Functions
  
  private class func aboutSection(provider: ServiceProviderType) -> Observable<SettingsViewSection> {
    let sectionsItems: [SettingsViewSectionItem] = [
      .openSource(SettingItemCellModel(text: "Open Source License".localized, detailText: nil))
    ]
    
    return .just(.about(sectionsItems))
  }
  
  private class func logoutSection(provider: ServiceProviderType) -> Observable<SettingsViewSection> {
    
    let logoutSectionItem: Observable<SettingsViewSectionItem> = provider.userService.currentUser
      .map { user -> SettingsViewSectionItem in
        .logout(SettingItemCellModel(text: "Logout".localized, detailText: user?.name))
    }
    
    return logoutSectionItem
      .map { sectionItem in [sectionItem] }
      .map { sectionItems in .logout(sectionItems) }
  }
  
}
