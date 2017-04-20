//
//  ShotFeedViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift
import RxSwiftUtilities

protocol ShotFeedViewModelType {
  // Input
  var dispose: PublishSubject<Void> { get }
  var refresh: PublishSubject<Void> { get }
  var loadMore: PublishSubject<Void> { get }
  
  // Output
  var isRefreshing: Driver<Bool> { get }
  var sections: Driver<[ShotFeedViewSection]> { get }
}

final class ShotFeedViewModel: ShotFeedViewModelType {
  
  // MARK: - Types
  
  fileprivate enum ShotOperation {
    case refresh([Shot])
    case loadMore([Shot])
  }
  
  // MARK: - Input
  
  let dispose: PublishSubject<Void> = .init()
  let refresh: PublishSubject<Void> = .init()
  let loadMore: PublishSubject<Void> = .init()
  
  // MARK: - Output
  
  let isRefreshing: Driver<Bool>
  let sections: Driver<[ShotFeedViewSection]>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType) {
    let isRefreshing = ActivityIndicator()
    let isLoading = ActivityIndicator()
    self.isRefreshing = isRefreshing.asDriver()
    
    let nextURL = Variable<URL?>(nil)
    
    let didRefreshShots = self.refresh
      .filter(!isRefreshing)
      .filter(!isLoading)
      .flatMap {
        provider.shotService.shots(paging: .refresh)
          .trackActivity(isRefreshing)
          .ignoreErrors()
      }
      .shareReplay(1)
    
    let didLoadMoreShots = self.loadMore
      .withLatestFrom(nextURL.asObservable())
      .filterNil()
      .filter(!isRefreshing)
      .filter(!isLoading)
      .flatMap { nextURL in
        provider.shotService.shots(paging: .next(nextURL))
          .trackActivity(isRefreshing)
          .ignoreErrors()
      }
      .shareReplay(1)
    
    _ = Observable.of(didRefreshShots, didLoadMoreShots)
      .merge()
      .map { $0.nextURL }
      .takeUntil(self.dispose)
      .bind(to: nextURL)
    
    let shotOperationRefresh: Observable<ShotOperation> = didRefreshShots
      .map { list in ShotOperation.refresh(list.items) }
      .shareReplay(1)
    
    let shotOperationLoadMore: Observable<ShotOperation> = didLoadMoreShots
      .do(onNext: { [weak nextURL] list in
        nextURL?.value = list.nextURL
      })
      .map { list in ShotOperation.loadMore(list.items) }
      .shareReplay(1)
    
    let shot: Observable<[Shot]> = Observable
      .of(shotOperationRefresh, shotOperationLoadMore)
      .merge()
      .scan([]) { shots, operation in
        switch operation {
        case let .refresh(newShots):
          return newShots
          
        case let .loadMore(newShots):
          return shots + newShots
        }
      }
      .startWith([])
      .shareReplay(1)
    
    let shotSection: Observable<[ShotFeedViewSection]> = shot
      .map { shots in
        let sectionItems = shots.map { shot -> ShotFeedViewSectionItem in
          let viewModel = ShotCellModel(provider: provider, shot: shot)
          return ShotFeedViewSectionItem.image(viewModel)
        }
        let section = ShotFeedViewSection.shotTile(sectionItems)
        return [section]
      }
      .shareReplay(1)
    
    self.sections = shotSection
      .asDriver(onErrorJustReturn: [])
  }
  
}
