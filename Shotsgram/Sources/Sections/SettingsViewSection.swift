//
//  SettingsViewSection.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxDataSources

enum SettingsViewSection {
  case about([SettingsViewSectionItem])
  case logout([SettingsViewSectionItem])
}

extension SettingsViewSection: SectionModelType {
  var items: [SettingsViewSectionItem] {
    switch self {
      case .about(let items): return items
      case .logout(let items): return items
    }
  }
  
  init(original: SettingsViewSection, items: [SettingsViewSectionItem]) {
    switch original {
      case .about: self = .about(items)
      case .logout: self = .logout(items)
    }
  }
  
}

enum SettingsViewSectionItem {
  case openSource(SettingItemCellModelType)
  case logout(SettingItemCellModelType)
}
