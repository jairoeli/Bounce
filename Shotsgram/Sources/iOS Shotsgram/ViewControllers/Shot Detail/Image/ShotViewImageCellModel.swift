//
//  ShotViewImageCellModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ShotViewImageCellModelType {
  // Output
  var imageViewURL: URL { get }
}

final class ShotViewImageCellModel: ShotViewImageCellModelType {
  
  // MARK: - Output
  
  let imageViewURL: URL
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.imageViewURL = shot.imageURLs.hidpi ?? shot.imageURLs.normal
  }
}
