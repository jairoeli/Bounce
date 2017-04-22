//
//  Snap.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

/// Ceil to snap pixel
func snap(_ x: CGFloat) -> CGFloat {
  let scale = UIScreen.main.scale
  return ceil(x * scale) / scale
}

func snap(_ point: CGPoint) -> CGPoint {
  return CGPoint(x: snap(point.x), y: snap(point.y))
}

func snap(_ size: CGSize) -> CGSize {
  return CGSize(width: snap(size.width), height: snap(size.height))
}

func snap(_ rect: CGRect) -> CGRect {
  return CGRect(origin: snap(rect.origin), size: snap(rect.size))
}
