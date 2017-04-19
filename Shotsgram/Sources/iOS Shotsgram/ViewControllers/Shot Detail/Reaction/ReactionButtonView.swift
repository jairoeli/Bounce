//
//  ReactionButtonView.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import RxReusable
import RxSwift

final class ReactionButtonView: UIView, RxReusableType {
  
  // MARK: - Constants
  
  fileprivate struct Metric {
    static let buttonSize = 20.f
    static let labelLeft = 6.f
  }
  
  fileprivate struct Font {
    static let label = UIFont.systemFont(ofSize: 12)
  }
  
  // MARK: - UI
  
  fileprivate let button = UIButton().then {
    $0.touchAreaInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
  }
  fileprivate let label = UILabel().then {
    $0.font = Font.label
  }
  
  // MARK: - Initializing
  
  init(image: UIImage?, selectedImage: UIImage? = nil) {
    super.init(frame: .zero)
    self.button.setBackgroundImage(image, for: .normal)
    self.button.setBackgroundImage(selectedImage, for: .selected)
    self.addSubview(self.button)
    self.addSubview(self.label)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configuring
  
  func configure(viewModel: ReactionButtonViewModelType) {
    // Input
    self.button.rx.tap
      .bind(to: viewModel.toggleReaction)
      .disposed(by: self.disposeBag)
    
    self.rx.deallocated
      .bind(to: viewModel.dispose)
      .disposed(by: self.disposeBag)
    
    // Output
    self.button.isSelected = viewModel.isReacted
    self.button.isUserInteractionEnabled = viewModel.canToggleReaction
    self.label.text = viewModel.text
    
    self.setNeedsLayout()
  }
  
  // MARK: - Size
  
  override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.setNeedsLayout()
    self.layoutIfNeeded()
    return CGSize(width: self.label.right, height: self.button.height)
  }
  
  class func height() -> CGFloat {
    return Metric.buttonSize
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.button.width = Metric.buttonSize
    self.button.height = Metric.buttonSize
    
    self.label.sizeToFit()
    self.label.left = self.button.right + Metric.labelLeft
    self.label.centerY = self.button.centerY
    
  }
  
}











