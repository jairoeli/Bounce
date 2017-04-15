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
  }
  
  // MARK: - Properties
  
  fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<ShotFeedViewSection>()
  
  // MARK: - UI
  
  fileprivate let refreshControl = UIRefreshControl()
  fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .clear
    $0.alwaysBounceVertical = true
    $0.register(Reusable.shotViewCell)
  }
  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  // MARK: - Initializing
  
  init(viewModel: ShotFeedViewModelType) {
    super.init()
    self.title = "Shot"
    self.configure(viewModel: viewModel)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .white
    
    self.collectionView.addSubview(self.refreshControl)
    self.view.addSubview(self.collectionView)
    self.view.addSubview(self.activityIndicatorView)
  }
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.activityIndicatorView.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
  }

  // MARK: Configuring
  
  private func configure(viewModel: ShotFeedViewModelType) {
    self.collectionView.rx.setDelegate(self).addDisposableTo(self.disposeBag)
    self.dataSource.configureCell = { dataSource, collectionView, indexPath, sectionItem in
      switch sectionItem {
        case .image(let viewModel):
        let cell = collectionView.dequeue(Reusable.shotViewCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
      }
    }
    
    // INPUT
    self.rx.viewDidLoad
      .bind(to: viewModel.refresh)
      .addDisposableTo(self.disposeBag)
    
    self.rx.deallocated
      .bind(to: viewModel.dispose)
      .addDisposableTo(self.disposeBag)
    
    self.refreshControl.rx.controlEvent(.valueChanged)
      .bind(to: viewModel.refresh)
      .addDisposableTo(self.disposeBag)
    
    self.collectionView.rx.isReachedBottom
      .bind(to: viewModel.loadMore)
      .addDisposableTo(self.disposeBag)
    
    // OUTPUT
    viewModel.isRefreshing
      .drive(self.refreshControl.rx.isRefreshing)
      .addDisposableTo(self.disposeBag)
    
    viewModel.sections
      .drive(self.collectionView.rx.items(dataSource: self.dataSource))
      .addDisposableTo(self.disposeBag)
    
  }
  
  
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ShotFeedViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let sectionWidth = collectionView.sectionWidth(at: indexPath.section)
    let sectionItem = self.dataSource[indexPath]
    
    switch sectionItem {
    case .image(let viewModel):
      return ShotViewCell.size(width: sectionWidth, viewModel: viewModel)
    }
  }
  
}










