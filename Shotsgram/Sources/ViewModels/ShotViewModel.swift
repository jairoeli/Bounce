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
  var viewDidLoad: PublishSubject<Void> { get }
  var refresh: PublishSubject<Void> { get }
  
  // Output
  var isRefreshing: Driver<Bool> { get }
  var sections: Driver<[ShotViewSection]> { get }
  
}

final class ShotViewModel: ShotViewModelType {
  
  // MARK: - Input
  
  let viewDidLoad: PublishSubject<Void> = .init()
  let refresh: PublishSubject<Void> = .init()
  
  // MARK: - Output
  
  let isRefreshing: Driver<Bool>
  let sections: Driver<[ShotViewSection]>
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType, shotID: Int, shot: Shot?) {
    let isRefreshing = ActivityIndicator()
    self.isRefreshing = isRefreshing.asDriver()
    
    let shotDidLoad: Observable<Shot> = Observable
      .of(self.viewDidLoad.asObservable(), self.refresh.asObservable())
      .merge()
      .flatMap {
        provider.shotService.shot(id: shotID)
          .trackActivity(isRefreshing)
          .ignoreErrors()
    }
    .map { $0 as Shot? }
    .startWith(shot)
    .filterNil()
    
    let shotSectionItemImage: Observable<ShotViewSectionItem> = shotDidLoad
      .map { shot in .image(ShotViewImageCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItemTitle: Observable<ShotViewSectionItem> = shotDidLoad
      .map { shot in .title(ShotViewTitleCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItemText: Observable<ShotViewSectionItem> = shotDidLoad
      .map { shot in .text(ShotViewTextCellModel(provider: provider, shot: shot)) }
      .shareReplay(1)
    
    let shotSectionItems = [shotSectionItemImage, shotSectionItemTitle, shotSectionItemText]
    let shotSection: Observable<ShotViewSection> = Observable<[ShotViewSectionItem]>
      .combineLatest(shotSectionItems) { $0 }
      .map { sectionItems in ShotViewSection.shot(sectionItems) }
    
    //
    // Section
    //
    let sections = [shotSection]
    self.sections = Observable<[ShotViewSection]>
      .combineLatest(sections) { $0 }
      .asDriver(onErrorJustReturn: [])
  }
  
}
