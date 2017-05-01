//
//  ShotViewImageCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class ShotViewImageCell: BaseCollectionViewCell {

  // MARK: - UI

  fileprivate let imageView = UIImageView()

  // MARK: - Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.imageView)
  }

  // MARK: - Configuring

  func configure(viewModel: ShotViewImageCellModelType) {
    // Output
    self.imageView.kf.setImage(with: viewModel.imageViewURL)
  }

  // MARK: - Size

  class func size(width: CGFloat, viewModel: ShotViewImageCellModelType) -> CGSize {
    return CGSize(width: width, height: ceil(width * 3 / 4))
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    self.imageView.frame = self.contentView.bounds
  }

}
