//
//  ShotViewCell.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import URLNavigator

final class ShotViewCell: BaseCollectionViewCell {
  
  // MARK: Constants
  
  fileprivate struct Metric {
    static let imageViewMargin = 6.f
  }
  
  
  // MARK: UI
  
  fileprivate let cardView = UIImageView().then {
    $0.image = UIImage.resizable()
      .border(color: .platinumBorder)
      .border(width: 1 / UIScreen.main.scale)
      .corner(radius: 2)
      .color(.white)
      .image
  }
  
  fileprivate let imageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
    $0.clipsToBounds = true
  }
  
  
  // MARK: Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.contentView.addSubview(self.cardView)
    self.cardView.addSubview(self.imageView)
  }
  
  
  // MARK: Configuring
  
  func configure(viewModel: ShotCellModelType) {
    // Input
    self.cardView.rx.tapGesture()
      .mapVoid()
      .bind(to: viewModel.showShot)
      .disposed(by: self.disposeBag)
    
    // Output
    self.imageView.kf.setImage(with: viewModel.imageURL, placeholder: nil)
    viewModel.presentShotViewController
      .whileDisplaying(self)
      .subscribe(onNext: { viewModel in
        Navigator.push(ShotViewController(viewModel: viewModel))
      })
      .disposed(by: self.disposeBag)
  }
  
  // MARK: Size
  
  class func size(width: CGFloat, viewModel: ShotCellModelType) -> CGSize {
    return CGSize(width: width, height: ceil(width * 3 / 4))
  }
  
  
  // MARK: Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.cardView.frame = self.contentView.bounds
    self.imageView.top = Metric.imageViewMargin
    self.imageView.left = Metric.imageViewMargin
    self.imageView.width = self.cardView.width - Metric.imageViewMargin * 2
    self.imageView.height = self.cardView.height - Metric.imageViewMargin * 2
  }
  
}
