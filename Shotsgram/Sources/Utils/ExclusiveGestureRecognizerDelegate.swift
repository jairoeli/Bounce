//
//  ExclusiveGestureRecognizerDelegate.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/15/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxGesture
import RxSwift
import RxCocoa

final class ExclusiveGestureRecognizerDelegate: NSObject, GestureRecognizerDelegate {

  static let shared = ExclusiveGestureRecognizerDelegate()

  func gestureRecognizer(_ gestureRecognizer: GestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: GestureRecognizer) -> Bool {
    return false
  }
}
