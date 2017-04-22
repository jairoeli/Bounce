//
//  ShotCellModelType.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ShotCellModelType {
  // Input
  var showShot: PublishSubject<Void> { get }
  
  // Output
  var imageURL: URL { get }
  var presentShotViewController: Observable<ShotViewModelType> { get }
}

final class ShotCellModel: ShotCellModelType {
  
  // MARK: - Input
  
  let showShot: PublishSubject<Void> = .init()
  
  // MARK: Output
  
  let imageURL: URL
  let presentShotViewController: Observable<ShotViewModelType>
  
  
  // MARK: Initializing
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.imageURL = shot.imageURLs.teaser
    self.presentShotViewController = self.showShot
      .map { ShotViewModel(provider: provider, shotID: shot.id, shot: shot) }
  }
  
}
