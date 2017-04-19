//
//  ShotViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import ReusableKit
import RxDataSources

final class ShotViewController: BaseViewController {
  
  // MARK: - Constants
  
  fileprivate struct Reusable {
    static let imageCell = ReusableCell<ShotViewImageCell>()
    static let titleCell = ReusableCell<ShotViewTitleCell>()
    static let textCell = ReusableCell<ShotViewTextCell>()
  }
  
  fileprivate struct Metric {}
  
  // MARK: - Property
  
  fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<ShotViewSection>()
  
  // MARK: - UI
  
  fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .clear
    $0.alwaysBounceVertical = true
    $0.register(Reusable.imageCell)
    $0.register(Reusable.titleCell)
    $0.register(Reusable.textCell)
  }
  
  // MARK: - Initializing
  
  init(viewModel: ShotViewModelType) {
    super.init()
    self.navigationItem.title = "Shot"
    self.configure(viewModel: viewModel)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .whiteSmoke
  }
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Configuring
  
  private func configure(viewModel: ShotViewModelType) {
    self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
    
    self.dataSource.configureCell = { dataSource, collectionView, indexPath, sectionItem in
      switch sectionItem {
        case .image(let viewModel):
        let cell = collectionView.dequeue(Reusable.imageCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
        
        case .title(let viewModel):
        let cell = collectionView.dequeue(Reusable.titleCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
        
        case .text(let viewModel):
        let cell = collectionView.dequeue(Reusable.textCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
      }
    }
    
    // Input
    self.rx.viewDidLoad
      .bind(to: viewModel.viewDidLoad)
      .disposed(by: self.disposeBag)
    
    // Output
    viewModel.sections
      .drive(self.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
  }
  
}

extension ShotViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionWidth = collectionView.sectionWidth(at: indexPath.section)
    let sectionItem = self.dataSource[indexPath]
    
    switch sectionItem {
      case .image(let viewModel): return ShotViewImageCell.size(width: sectionWidth, viewModel: viewModel)
      case .title(let viewModel): return ShotViewTitleCell.size(width: sectionWidth, viewModel: viewModel)
      case .text(let viewModel): return ShotViewTextCell.size(width: sectionWidth, viewModel: viewModel)
    }
  }
  
}
