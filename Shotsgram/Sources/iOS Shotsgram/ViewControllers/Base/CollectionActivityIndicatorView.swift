//
//  CollectionActivityIndicatorView.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/15/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class CollectionActivityIndicatorView: UICollectionReusableView {
  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.activityIndicatorView.startAnimating()
    self.addSubview(self.activityIndicatorView)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    self.activityIndicatorView.centerX = self.width / 2
    self.activityIndicatorView.centerY = self.height / 2
  }
}
