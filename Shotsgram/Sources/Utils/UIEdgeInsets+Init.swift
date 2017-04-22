//
//  UIEdgeInsets+Init.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
  
  init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
    self.top = top
    self.left = left
    self.bottom = bottom
    self.right = right
  }
  
  init(topBottom: CGFloat = 0, leftRight: CGFloat = 0) {
    self.top = topBottom
    self.left = leftRight
    self.bottom = topBottom
    self.right = leftRight
  }
  
}
