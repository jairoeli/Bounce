//
//  ShotViewController.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import ReusableKit
import RxCocoa
import RxDataSources

final class ShotViewController: BaseViewController {
  
  // MARK: - Constants
  
  fileprivate struct Reusable {
    static let imageCell = ReusableCell<ShotViewImageCell>()
    static let titleCell = ReusableCell<ShotViewTitleCell>()
    static let textCell = ReusableCell<ShotViewTextCell>()
    static let reactionCell = ReusableCell<ReactionCell>()
    static let commentCell = ReusableCell<CommentCell>()
    static let activityIndicatorCell = ReusableCell<CollectionActivityIndicatorCell>()
  }
  
  fileprivate struct Metric {}
  
  // MARK: - Property
  
  fileprivate let dataSource = RxCollectionViewSectionedReloadDataSource<ShotViewSection>()
  
  // MARK: - UI
  
  fileprivate let refreshControl = UIRefreshControl()
  fileprivate let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
    $0.backgroundColor = .clear
    $0.alwaysBounceVertical = true
    $0.register(Reusable.imageCell)
    $0.register(Reusable.titleCell)
    $0.register(Reusable.textCell)
    $0.register(Reusable.reactionCell)
    $0.register(Reusable.commentCell)
    $0.register(Reusable.activityIndicatorCell)
  }
  fileprivate let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
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
    self.collectionView.addSubview(self.refreshControl)
    self.view.addSubview(self.collectionView)
    self.view.addSubview(self.activityIndicatorView)
  }
  
  override func setupConstraints() {
    self.collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    self.activityIndicatorView.snp.makeConstraints { (make) in
      make.center.equalToSuperview()
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
        
        case .reaction(let viewModel):
        let cell = collectionView.dequeue(Reusable.reactionCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
        
        case .comment(let viewModel):
        let cell = collectionView.dequeue(Reusable.commentCell, for: indexPath)
        cell.configure(viewModel: viewModel)
        return cell
        
        case .activityIndicator: return collectionView.dequeue(Reusable.activityIndicatorCell, for: indexPath)
      }
    }
    
    // Input
    self.rx.deallocated
      .bind(to: viewModel.dispose)
      .disposed(by: self.disposeBag)
    
    self.rx.viewDidLoad
      .bind(to: viewModel.refresh)
      .disposed(by: self.disposeBag)
    
    self.refreshControl.rx.controlEvent(.valueChanged)
      .bind(to: viewModel.refresh)
      .disposed(by: self.disposeBag)
    
    // Output
    viewModel.sections
      .map { $0.isEmpty }
      .drive(self.collectionView.rx.isHidden)
      .disposed(by: self.disposeBag)
    
    Driver.combineLatest(viewModel.isRefreshing, viewModel.sections.map { $0.isEmpty }) { $0 && $1 }
      .drive(self.activityIndicatorView.rx.isAnimating)
      .disposed(by: self.disposeBag)
    
    viewModel.isRefreshing
      .drive(self.refreshControl.rx.isRefreshing)
      .disposed(by: self.disposeBag)
    
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
      case .reaction(let viewModel): return ReactionCell.size(width: sectionWidth, viewModel: viewModel)
      case .comment(let viewModel): return CommentCell.size(width: width, viewModel: viewModel)
      case .activityIndicator: return CollectionActivityIndicatorCell.size(width: width)
    }
  }
  
}
