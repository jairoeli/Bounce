//
//  ShotViewSection.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxDataSources

enum ShotViewSection {
  case shot([ShotViewSectionItem])
  case comment([ShotViewSectionItem])
}

extension ShotViewSection: SectionModelType {
  var items: [ShotViewSectionItem] {
    switch self {
      case .shot(let items): return items
      case .comment(let items): return items
    }
  }
  
  init(original: ShotViewSection, items: [ShotViewSectionItem]) {
    switch original {
      case .shot: self = .shot(items)
      case .comment: self = .comment(items)
    }
  }
  
}

enum ShotViewSectionItem {
  case image(ShotViewImageCellModelType)
  case title(ShotViewTitleCellModelType)
  case text(ShotViewTextCellModelType)
  case reaction(ReactionCellModelType)
  case comment(CommentCellModelType)
  case activityIndicator
}
