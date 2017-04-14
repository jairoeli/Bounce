//
//  ShotFeedViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class ShotFeedViewController: BaseViewController {
  
  // MARK: - Initializing
  
  init(viewModel: ShotFeedViewModelType) {
    super.init()
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: Configuring
  
  private func configure(viewModel: ShotFeedViewModelType) {
    
  }
  
}
