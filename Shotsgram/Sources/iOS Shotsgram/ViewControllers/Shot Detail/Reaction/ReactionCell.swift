//
//  ReactionCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class ReactionCell: BaseCollectionViewCell {

  // MARK: - Constants

  fileprivate struct Metric {
    static let paddingTop = 5.f
    static let paddingLeftRight = 15.f
    static let paddingBottom = 10.f
    static let buttonViewSpacing = 10.f
  }

  // MARK: - UI

  override class var layerClass: AnyClass {
    return BorderedLayer.self
  }

  fileprivate let likeButtonView = ReactionButtonView(image: #imageLiteral(resourceName: "icon_like"), selectedImage: #imageLiteral(resourceName: "icon_like_selected"))
  fileprivate let commentButtonView = ReactionButtonView(image: #imageLiteral(resourceName: "icon_comment"))

  // MARK: - Initializing

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.borderedLayer?.borders = .bottom
    self.contentView.addSubview(self.likeButtonView)
    self.contentView.addSubview(self.commentButtonView)
  }

  // MARK: - Configure

  func configure(viewModel: ReactionCellModelType) {
    self.likeButtonView.configure(viewModel: viewModel.likeButtonViewModel)
    self.commentButtonView.configure(viewModel: viewModel.commentButtonViewModel)
    self.setNeedsLayout()
  }

  // MARK: - Size

  class func size(width: CGFloat, viewModel: ReactionCellModelType) -> CGSize {
    let buttonViewHeight = ReactionButtonView.height()
    let height = Metric.paddingTop + buttonViewHeight + Metric.paddingBottom
    return CGSize(width: width, height: height)
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    self.likeButtonView.sizeToFit()
    self.likeButtonView.left = Metric.paddingLeftRight

    self.commentButtonView.sizeToFit()
    self.commentButtonView.left = self.likeButtonView.right + Metric.buttonViewSpacing
  }

}
