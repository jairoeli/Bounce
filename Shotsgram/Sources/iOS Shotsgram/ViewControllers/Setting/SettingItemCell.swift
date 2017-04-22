//
//  SettingItemCell.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class SettingItemCell: BaseTableViewCell {
  
  // MARK: - Initializing
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    self.accessoryType = .disclosureIndicator
  }
  
  // MARK: - Configuring
  func configure(viewModel: SettingItemCellModelType) {
    self.textLabel?.text = viewModel.textLabelText
    self.detailTextLabel?.text = viewModel.detailTextLabel
  }
  
}
