//
//  SettingsViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import SafariServices
import ReusableKit
import RxDataSources

final class SettingsViewController: BaseViewController {
  
  // MARK: - Constants
  
  fileprivate struct Reusable {
    static let cell = ReusableCell<SettingItemCell>()
  }
  
  // MARK: - Property
  
  fileprivate let dataSource = RxTableViewSectionedReloadDataSource<SettingsViewSection>()
  
  // MARK: - UI
  
  fileprivate let tableView = UITableView(frame: .zero, style: .grouped).then {
    $0.register(Reusable.cell)
  }
  
  // MARK: - Initializing
  
  init(viewModel: SettingsViewModelType) {
    super.init()
//    self.title = "Settings".localized
    self.navigationItem.title = "Settings".localized
    self.tabBarItem.image = #imageLiteral(resourceName: "setting")
    self.tabBarItem.selectedImage = #imageLiteral(resourceName: "setting_selected").withRenderingMode(.alwaysOriginal)
    self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.tableView)
  }
  
  override func setupConstraints() {
    self.tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Configuring
  
  private func configure(viewModel: SettingsViewModelType) {
    self.dataSource.configureCell = { dataSource, tableView, indexPath, sectionItem in
      let cell = tableView.dequeue(Reusable.cell, for: indexPath)
      
      switch sectionItem {
        case .openSource(let viewModel): cell.configure(viewModel: viewModel)
        case .logout(let viewModel): cell.configure(viewModel: viewModel)
        case .icons(let viewModel): cell.configure(viewModel: viewModel)
      }
      
      return cell
    }
    
    // Input
    self.tableView.rx.itemSelected(dataSource: self.dataSource)
      .bind(to: viewModel.tableViewDidSelectItem)
      .disposed(by: self.disposeBag)
    
    // Output
    viewModel.tableViewSections
      .drive(self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
    viewModel.presentWebViewController
      .subscribe(onNext: { [weak self] url in
        guard let `self` = self else { return }
        let viewController = SFSafariViewController(url: url)
        
        self.present(viewController, animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    viewModel.presentLogoutAlert
      .subscribe(onNext: { [weak self] actionItems in
        guard let `self` = self else { return }
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionItems
          .map { actionItem -> UIAlertAction in
            let title: String
            let style: UIAlertActionStyle
            
            switch actionItem {
              case .logout:
              title = "Logout".localized
              style = .destructive
              
              case .cancel:
              title = "Cancel".localized
              style = .cancel
            }
            return UIAlertAction(title: title, style: style) { _ in
              viewModel.logoutAlertDidSelectActionItem.onNext(actionItem)
            }
        }
        .forEach(actionSheet.addAction)
        self.present(actionSheet, animated: true, completion: nil)
      })
      .disposed(by: self.disposeBag)
    
    viewModel.presentOpenSourceViewController
      .subscribe(onNext: { [weak self] in
        self?.navigationController?.pushViewController(OpenSourceViewController(), animated: true)
      })
      .disposed(by: self.disposeBag)
    
    viewModel.presentLoginScreen
      .subscribe(onNext: { viewModel in
        AppDelegate.shared.presentLoginScreen(viewModel: viewModel)
      })
      .disposed(by: self.disposeBag)
    
    // UI
    self.tableView.rx.itemSelected
      .subscribe(onNext: { [weak tableView] indexPath in
        tableView?.deselectRow(at: indexPath, animated: false)
      })
      .disposed(by: self.disposeBag)
    
  }
  
}
