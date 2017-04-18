//
//  SettingItemCellModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol SettingItemCellModelType {
  var textLabelText: String? { get }
  var detailTextLabel: String? { get }
}

final class SettingItemCellModel: SettingItemCellModelType {
  
  let textLabelText: String?
  let detailTextLabel: String?
  
  init(text: String?, detailText: String?) {
    self.textLabelText = text
    self.detailTextLabel = detailText
  }
  
}
