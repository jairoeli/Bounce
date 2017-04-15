//
//  BaseViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
  
  // MARK: Properties
  
  lazy private(set) var className: String = {
    return type(of: self).description().components(separatedBy: ".").last ?? ""
  }()
  
  // MARK: - Initializing
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    log.verbose("DEINIT: \(self.className)")
  }
  
  // MARK: - Rx
  let disposeBag = DisposeBag()
  
  // MARK: - Layout Constraints
  
  private(set) var didSetupConstraints = false
  
  override func viewDidLoad() {
    self.view.setNeedsUpdateConstraints()
  }
  
  override func updateViewConstraints() {
    if !self.didSetupConstraints {
      self.setupConstraints()
      self.didSetupConstraints = true
    }
    
    super.updateViewConstraints()
  }
  
  func setupConstraints() {
    // Override point
  }
  
}
