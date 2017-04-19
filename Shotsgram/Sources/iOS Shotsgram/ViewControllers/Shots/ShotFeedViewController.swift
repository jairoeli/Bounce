//
//  ShotFeedViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import ReusableKit
import RxCocoa
import RxDataSources

final class ShotFeedViewController: BaseViewController {
  
  // MARK: - Constants
  
  fileprivate struct Reusable {
    static let shotViewCell = ReusableCell<ShotViewCell>()
    static let activityIndicatorView = ReusableView<CollectionActivityIndicatorView>()
    static let emptyView = ReusableView<UICollectionReusableView>()
  }
  
  fileprivate struct Constant {
    static let shotTileSectionColumnCount = 2
  }
  
  fileprivate struct Metric {
    static let shotTileSectionInsetLeftRight = 10.f
    static let shotTileSectionItemSpacing = 10.f
  }
  
  // MARK: - Properties
  
  fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<ShotFeedViewSection>()
  
  // MARK: - UI
  
  fileprivate let refreshControl = UIRefreshControl()
  fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .clear
    $0.alwaysBounceVertical = true
    $0.register(Reusable.shotViewCell)
    $0.register(Reusable.activityIndicatorView, kind: UICollectionElementKindSectionFooter)
    $0.register(Reusable.emptyView, kind: "empty")
  }
  
  // MARK: - Initializing
  
  init(viewModel: ShotFeedViewModelType) {
    super.init()
//    self.title = "Shot"
    self.navigationItem.title = "Shots"
    self.tabBarItem.image = #imageLiteral(resourceName: "shots")
    self.tabBarItem.selectedImage = #imageLiteral(resourceName: "shots_selected").withRenderingMode(.alwaysOriginal)
    self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .whiteSmoke
    self.view.addSubview(self.collectionView)
    self.collectionView.addSubview(self.refreshControl)
  }
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }

  // MARK: Configuring
  
  private func configure(viewModel: ShotFeedViewModelType) {
    
    self.collectionView.rx.setDelegate(self).disposed(by: self.disposeBag)
    self.dataSource.configureCell = { dataSource, collectionView, indexPath, sectionItem in
      switch sectionItem {
        case .image(let viewModel):
        let cell = collectionView.dequeue(Reusable.shotViewCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
      }
    }
    self.dataSource.supplementaryViewFactory = { dataSource, collectionView, kind, indexPath in
      if kind == UICollectionElementKindSectionFooter {
        return collectionView.dequeue(Reusable.activityIndicatorView, kind: kind, for: indexPath)
      }
      return collectionView.dequeue(Reusable.emptyView, kind: "empty", for: indexPath)
    }

    
    // INPUT
    self.rx.viewDidLoad
      .bind(to: viewModel.refresh)
      .disposed(by: self.disposeBag)
    
    self.rx.deallocated
      .bind(to: viewModel.dispose)
      .disposed(by: self.disposeBag)
    
    self.refreshControl.rx.controlEvent(.valueChanged)
      .bind(to: viewModel.refresh)
      .disposed(by: self.disposeBag)
    
    self.collectionView.rx.isReachedBottom
      .bind(to: viewModel.loadMore)
      .disposed(by: self.disposeBag)
    
    // OUTPUT
    viewModel.isRefreshing
      .drive(self.refreshControl.rx.isRefreshing)
      .disposed(by: self.disposeBag)
    
    viewModel.sections
      .drive(self.collectionView.rx.items(dataSource: self.dataSource))
      .disposed(by: self.disposeBag)
    
  }
  
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShotFeedViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
    switch self.dataSource[section] {
      case .shotTile:
      let topBottom = Metric.shotTileSectionItemSpacing
      let leftRight = Metric.shotTileSectionInsetLeftRight
      return UIEdgeInsets(top: topBottom, left: leftRight, bottom: topBottom, right: leftRight)
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    switch self.dataSource[section] {
      case .shotTile:
      return Metric.shotTileSectionItemSpacing
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch self.dataSource[section] {
      case .shotTile:
      return Metric.shotTileSectionItemSpacing
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionWidth = collectionView.sectionWidth(at: indexPath.section)
    let sectionItem = self.dataSource[indexPath]
    
    switch sectionItem {
      case .image(let viewModel):
      let columnCount = Constant.shotTileSectionColumnCount.f
      let cellWidth = (sectionWidth - Metric.shotTileSectionItemSpacing) / columnCount
      return ShotViewCell.size(width: cellWidth, viewModel: viewModel)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    return CGSize(width: collectionView.width, height: 44)
  }
  
}
