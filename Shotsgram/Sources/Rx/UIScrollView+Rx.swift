//
//  UIScrollView+Rx.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

extension Reactive where Base: UIScrollView {

  var isReachedBottom: ControlEvent<Void> {
    let source = self.contentOffset
      .filter { [weak base = self.base] _ in
        guard let base = base else { return false }
        return base.isReachedBottom(withTolerance: base.height / 2)
    }
    .map { _ in Void() }

    return ControlEvent(events: source)
  }

}
