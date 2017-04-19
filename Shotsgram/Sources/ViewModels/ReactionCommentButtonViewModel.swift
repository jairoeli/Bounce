//
//  ReactionCommentButtonViewModel.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

final class ReactionCommentButtonViewModel: ReactionButtonViewModelType {
  
  // MARK: - Input
  
  let dispose: PublishSubject<Void> = .init()
  let toggleReaction: PublishSubject<Void> = .init()
  
  // MARK: - Output
  
  let isReacted: Bool
  let canToggleReaction: Bool
  let text: String
  
  // MARK: - Initializing
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.isReacted = false
    self.canToggleReaction = true
    self.text = "\(shot.commentCount)"
  }
  
}
