//
//  ShotFeedViewSection.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxDataSources

enum ShotFeedViewSection {
  case shotTile([ShotFeedViewSectionItem])
}

extension ShotFeedViewSection: SectionModelType {
  
  var items: [ShotFeedViewSectionItem] {
    switch self {
      case .shotTile(let items): return items
    }
  }
  
  init(original: ShotFeedViewSection, items: [ShotFeedViewSectionItem]) {
    switch original {
      case .shotTile: self = .shotTile(items)
    }
  }
  
}

enum ShotFeedViewSectionItem {
  case image(ShotCellModelType)
}
