//
//  ShotCellModelType.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ShotCellModelType {
  // Output
  var imageURL: URL { get }
}

final class ShotCellModel: ShotCellModelType {
  
  // MARK: Output
  let imageURL: URL
  
  
  // MARK: Initializing
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.imageURL = shot.imageURLs.teaser
  }
  
}
