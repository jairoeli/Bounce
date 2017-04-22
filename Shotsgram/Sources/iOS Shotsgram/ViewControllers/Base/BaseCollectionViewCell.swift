//
//  BaseCollectionViewCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
  
  // MARK: - Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    self.init(frame: .zero)
  }
  
}
