//
//  CollectionActivityIndicatorCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class CollectionActivityIndicatorCell: BaseCollectionViewCell {
  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.activityIndicatorView.startAnimating()
    self.addSubview(self.activityIndicatorView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  class func size(width: CGFloat) -> CGSize {
    return CGSize(width: width, height: 44)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.activityIndicatorView.centerX = self.width / 2
    self.activityIndicatorView.centerY = self.height / 2
  }
  
}
