//
//  ReactionButtonViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

enum ShotReactionType {
  case like
}

protocol ReactionButtonViewModelType {
  // Input
  var dispose: PublishSubject<Void> { get }
  var toggleReaction: PublishSubject<Void> { get }
  
  // Output
  var isReacted: Bool { get }
  var canToggleReaction: Bool { get }
  var text: String { get }
}
