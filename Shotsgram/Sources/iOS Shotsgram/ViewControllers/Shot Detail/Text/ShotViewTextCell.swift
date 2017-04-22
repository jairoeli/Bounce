//
//  ShotViewTextCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import TTTAttributedLabel

final class ShotViewTextCell: BaseCollectionViewCell {
  
  // MARK: - Constants
  
  fileprivate struct Metric {
    static let paddingTop = 0.f
    static let paddingBottom = 10.f
    static let paddingLeftRight = 15.f
  }
  
  // MARK: - UI
  
  fileprivate let label = TTTAttributedLabel(frame: .zero).then {
    $0.numberOfLines = 0
    $0.linkAttributes = [NSForegroundColorAttributeName: UIColor.pink]
    $0.activeLinkAttributes = [NSForegroundColorAttributeName: UIColor.darkPink]
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.contentView.addSubview(self.label)
  }
  
  // MARK: - Configuring
  
  func configure(viewModel: ShotViewTextCellModelType) {
    self.label.setText(viewModel.text)
    self.setNeedsLayout()
  }
  
  class func size(width: CGFloat, viewModel: ShotViewTextCellModelType) -> CGSize {
    guard let labelText = viewModel.text else { return CGSize(width: width, height: 0) }
    let labelWidth = width - Metric.paddingLeftRight * 2
    let labelHeight = labelText.height(thatFitsWidth: labelWidth)
    return CGSize(width: width, height: labelHeight + Metric.paddingTop + Metric.paddingBottom)
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    self.label.top = Metric.paddingTop
    self.label.left = Metric.paddingLeftRight
    self.label.width = self.contentView.width - Metric.paddingLeftRight * 2
    self.label.sizeToFit()
  }
  
}
