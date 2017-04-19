//
//  NSAttributedString+BoundingRect.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import TTTAttributedLabel

extension NSAttributedString {
  
  func size(thatFits size: CGSize, limitedToNumberOfLines: Int = 0) -> CGSize {
    let size = TTTAttributedLabel.sizeThatFitsAttributedString(self, withConstraints: size, limitedToNumberOfLines: UInt(limitedToNumberOfLines))
    return snap(size)
  }
  
  /*
   var width: CGFloat {
   let constraintSize = CGSize(
   width: CGFloat.greatestFiniteMagnitude,
   height: CGFloat.greatestFiniteMagnitude
   )
   return self.size(thatFits: constraintSize).width
   }
   */
  
  func height(thatFitsWidth width: CGFloat) -> CGFloat {
    let constraintSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    return self.size(thatFits: constraintSize).height
  }
  
}
