//
//  ShotViewCell.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class ShotViewCell: BaseCollectionViewCell {
  
  // MARK: - UI
  
  fileprivate let imageView = UIImageView()
  
  // MARK: - Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.imageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuring
  func configure(viewModel: ShotCellModelType) {
    self.imageView.kf.setImage(with: viewModel.imageURL)
  }
  
  // MARK: - Size
  
  class func size(width: CGFloat, viewModel: ShotCellModelType) -> CGSize {
    return CGSize(width: width, height: ceil(width * 3 / 4))
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView.frame = self.contentView.bounds
  }
  
}
