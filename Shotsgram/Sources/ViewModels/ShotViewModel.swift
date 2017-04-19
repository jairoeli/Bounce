//
//  ShotViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift
import RxSwiftUtilities

protocol ShotViewModelType {
  // Input
  var dispose: PublishSubject<Void> { get }
  var refresh: PublishSubject<Void> { get }
  
  // Output
  var isRefreshing: Driver<Bool> { get }
  var sections: Driver<[ShotViewSection]> { get }
  
}

final class ShotViewModel: ShotViewModelType {
  
  // MARK: - Input
  
  let dispose: PublishSubject<Void> = .init()
  let refresh: PublishSubject<Void> = .init()
  
  // MARK: - Output
  
  let isRefreshing: Driver<Bool>
  let sections: Driver<[ShotViewSection]>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType, shotID: Int, shot initialShot: Shot? = nil) {
    let shot: Observable<Shot> = Shot.event
      .scan(initialShot) { oldShot, event in
        switch event {
          case let .create(newShot):
            guard newShot.id == shotID else { return oldShot }
            return newShot
          
          case let .update(newShot):
            guard newShot.id == shotID else { return oldShot }
            return newShot
          
          case let .delete(id):
            guard id == shotID else { return oldShot }
            return nil
          
          case let .like(id):
            guard id == shotID else { return oldShot }
            return oldShot?.with {
              $0.isLiked = true
              $0.likeCount += 1
          }
          
          case let .unlike(id):
            guard id == shotID else { return oldShot }
            return oldShot?.with {
              $0.isLiked = false
              $0.likeCount -= 1
          }
        }
    }
    .startWith(initialShot)
    .filterNil()
    .shareReplay(1)
    
    let isRefreshing = ActivityIndicator()
    self.isRefreshing = isRefreshing.asDriver()
    
    let didRefreshShot = self.refresh
      .filter(!isRefreshing)
      .flatMap {
        provider.shotService.shot(id: shotID)
          .trackActivity(isRefreshing)
          .ignoreErrors()
    }
    .shareReplay(1)
    
    // Refresh shot
    _ = didRefreshShot
      .map(Shot.Event.update)
      .takeUntil(self.dispose)
      .bind(to: Shot.event)
    
    // Refresh isLiked
    _ = didRefreshShot
      .flatMap { shot in
        provider.shotService.isLiked(shotID: shotID)
          .catchErrorJustReturn(false)
          .map { isLiked -> Shot in
            var newShot = shot
            newShot.isLiked = isLiked
            return newShot
        }
    }
    .map(Shot.Event.update)
    .takeUntil(self.dispose)
    .bind(to: Shot.event)


    let shotSectionItemImage: Observable<ShotViewSectionItem> = shot
      .map { shot in .image(ShotViewImageCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItemTitle: Observable<ShotViewSectionItem> = shot
      .map { shot in .title(ShotViewTitleCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItemText: Observable<ShotViewSectionItem> = shot
      .map { shot in .text(ShotViewTextCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItemReaction: Observable<ShotViewSectionItem> = shot
      .map { shot in .reaction(ReactionCellModel(provider: provider, shot: shot)) }
    
    let shotSectionItems = [shotSectionItemImage, shotSectionItemTitle, shotSectionItemText, shotSectionItemReaction]
    
    let shotSection: Observable<ShotViewSection> = Observable<[ShotViewSectionItem]>
      .combineLatest(shotSectionItems) { $0 }
      .startWith([])
      .map { sectionItems in ShotViewSection.shot(sectionItems) }
      .shareReplay(1)
    
    //
    // Section
    //
    let sections = [shotSection]
    self.sections = Observable<[ShotViewSection]>
      .combineLatest(sections) { $0 }
      .asDriver(onErrorJustReturn: [])
  }
  
}
