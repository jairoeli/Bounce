//
//  SettingsViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
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
        case .item(let viewModel): cell.configure(viewModel: viewModel)
      }
      
      return cell
    }
    
    // Input
    self.tableView.rx.itemSelected
      .bind(to: viewModel.tableViewDidSelectItem)
      .disposed(by: self.disposeBag)
    
    // Output
    viewModel.tableViewSections
      .drive(self.tableView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
  }
  
}
