//
//  CommentCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import TTTAttributedLabel

final class CommentCell: BaseCollectionViewCell {
  
  // MARK: - Constants
  
  fileprivate struct Metric {
    static let paddingTopBottom = 10.f
    static let paddingLeftRight = 15.f
    
    static let avatarViewSize = 30.f
    static let nameLabelLeft = 8.f
    
    static let messageLabelTop = 0.f
    static let messageLabelLeft = nameLabelLeft
  }
  
  fileprivate struct Font {
    static let nameLabel = UIFont.boldSystemFont(ofSize: 14)
  }
  
  // MARK: - UI
  
  fileprivate let avatarView = UIImageView().then {
    $0.layer.cornerRadius = Metric.avatarViewSize / 2
    $0.clipsToBounds = true
  }
  
  fileprivate let nameLabel = UILabel().then {
    $0.font = Font.nameLabel
  }
  
  fileprivate let messageLabel = TTTAttributedLabel(frame: .zero).then {
    $0.numberOfLines = 0
    $0.linkAttributes = [NSForegroundColorAttributeName: UIColor.pink]
    $0.activeLinkAttributes = [NSForegroundColorAttributeName: UIColor.darkPink]
  }
  
  // MARK: - Initializing
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.contentView.addSubview(self.avatarView)
    self.contentView.addSubview(self.nameLabel)
    self.contentView.addSubview(self.messageLabel)
  }
  
  // MARK: - Configuring
  
  func configure(viewModel: CommentCellModelType) {
    self.avatarView.kf.setImage(with: viewModel.avatarURL)
    self.nameLabel.text = viewModel.name
    self.messageLabel.setText(viewModel.message)
    self.setNeedsLayout()
  }
  
  // MARK: - Size
  
  class func size(width: CGFloat, viewModel: CommentCellModelType) -> CGSize {
    var height: CGFloat = 0
    height += Metric.paddingTopBottom
    height += snap(Font.nameLabel.lineHeight)
    
    let messageLabelMaxWidth = width
      - Metric.paddingLeftRight * 2
      - Metric.avatarViewSize
      - Metric.messageLabelLeft
    height += Metric.messageLabelTop
    height += viewModel.message.height(thatFitsWidth: messageLabelMaxWidth)
    height += Metric.paddingTopBottom
    return CGSize(width: width, height: height)
  }
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.avatarView.top = Metric.paddingTopBottom
    self.avatarView.left = Metric.paddingLeftRight
    self.avatarView.width = Metric.avatarViewSize
    self.avatarView.height = Metric.avatarViewSize
    
    self.nameLabel.sizeToFit()
    self.nameLabel.top = Metric.paddingTopBottom
    self.nameLabel.left = self.avatarView.right + Metric.nameLabelLeft
    self.nameLabel.width = min(self.nameLabel.width, self.contentView.width - self.nameLabel.left - Metric.paddingLeftRight)
    
    self.messageLabel.top = self.nameLabel.bottom + Metric.messageLabelTop
    self.messageLabel.left = self.avatarView.right + Metric.messageLabelLeft
    self.messageLabel.width = self.contentView.width - self.messageLabel.left - Metric.paddingLeftRight
    self.messageLabel.sizeToFit()
  }
  
}
