//
//  ShotViewTitleCellModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/15/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol ShotViewTitleCellModelType {
  //Output
  var avatarURL: URL? { get }
  var title: String { get }
  var username: String { get }
}

final class ShotViewTitleCellModel: ShotViewTitleCellModelType {
  
  // MARK: Output
  let avatarURL: URL?
  let title: String
  let username: String
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.avatarURL = shot.user.avatarURL
    self.title = shot.title
    self.username = "by \(shot.user.name)"
  }
  
}
