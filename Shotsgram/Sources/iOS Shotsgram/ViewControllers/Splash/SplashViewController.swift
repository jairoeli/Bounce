//
//  SplashViewController.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

final class SplashViewController: BaseViewController {
  
  // MARK: - UI
   fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  // MARK: - Initializing
  
  init(viewModel: SplashViewModelType) {
    super.init()
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.activityIndicatorView.startAnimating()
    self.view.addSubview(self.activityIndicatorView)
  }
  
  override func setupConstraints() {
    self.activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }
  
  // MARK: - Configuring
  
  private func configure(viewModel: SplashViewModelType) {
    // INPUT
    self.rx.viewDidAppear
      .map { _ in Void() }
      .bind(to: viewModel.checkIfAuthenticated)
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    viewModel.presentLoginScreen
      .subscribe(onNext: { viewModel in
        AppDelegate.shared.presentLoginScreen(viewModel: viewModel)
      })
      .disposed(by: self.disposeBag)
    
    viewModel.presentMainScreen
      .subscribe(onNext: { viewModel in
        AppDelegate.shared.presentMainScreen(viewModel: viewModel)
      })
      .disposed(by: self.disposeBag)
  }
  
}
