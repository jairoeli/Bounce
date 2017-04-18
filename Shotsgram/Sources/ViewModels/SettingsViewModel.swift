//
//  SettingsViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol SettingsViewModelType {
  // input
  var tableViewDidSelectItem: PublishSubject<IndexPath> { get }
  
  // output
  var tableViewSections: Driver<[SettingsViewSection]> { get }
}

final class SettingsViewModel: SettingsViewModelType {
  
  // MARK: - Input
  
  let tableViewDidSelectItem: PublishSubject<IndexPath> = .init()
  
  // MARK: - Output
  
  let tableViewSections: Driver<[SettingsViewSection]>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType) {
    let cls = SettingsViewModel.self
    
    let sections = [cls.aboutSection(provider: provider), cls.logoutSection(provider: provider)]
    
    self.tableViewSections = Observable
      .combineLatest(sections) { $0 }
      .asDriver(onErrorJustReturn: [])
  }
  
  // MARK: - Functions
  
  private class func aboutSection(provider: ServiceProviderType) -> Observable<SettingsViewSection> {
    let sectionsItems: [SettingsViewSectionItem] = [
      .item(SettingItemCellModel(text: "Open Source License".localized, detailText: nil))
    ]
    
    return .just(.about(sectionsItems))
  }
  
  private class func logoutSection(provider: ServiceProviderType) -> Observable<SettingsViewSection> {
    
    let logoutSectionItem: Observable<SettingsViewSectionItem> = provider.userService.currentUser
      .map { user -> SettingsViewSectionItem in
        .item(SettingItemCellModel(text: "Logout".localized, detailText: user?.name))
    }
    
    return logoutSectionItem
      .map { sectionItem in [sectionItem] }
      .map { sectionItems in .logout(sectionItems) }
  }
  
}
