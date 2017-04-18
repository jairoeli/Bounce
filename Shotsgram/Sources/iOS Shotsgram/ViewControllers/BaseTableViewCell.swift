//
//  BaseTableViewCell.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import RxSwift

class BaseTableViewCell: UITableViewCell {
  
  // MARK: Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(style: .default, reuseIdentifier: nil)
  }
  
}
