//
//  ShotFeedViewSection.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxDataSources

enum ShotFeedViewSection {
  case shot([ShotFeedViewSectionItem])
//  case comment([ShotFeedViewSectionItem])
}

extension ShotFeedViewSection: SectionModelType {
  
  var items: [ShotFeedViewSectionItem] {
    switch self {
      case .shot(let items): return items
//      case .comment(let items): return items
    }
  }
  
  init(original: ShotFeedViewSection, items: [ShotFeedViewSectionItem]) {
    switch original {
      case .shot: self = .shot(items)
//      case .comment: self = .comment(items)
    }
  }
  
}

enum ShotFeedViewSectionItem {
  case image(ShotCellModelType)
}
