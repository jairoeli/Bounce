//
//  ReactionCellModel.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

protocol ReactionCellModelType: class {
  var likeButtonViewModel: ReactionButtonViewModelType { get }
  var commentButtonViewModel: ReactionButtonViewModelType { get }
}

final class ReactionCellModel: ReactionCellModelType {
  
  let likeButtonViewModel: ReactionButtonViewModelType
  let commentButtonViewModel: ReactionButtonViewModelType
  
  init(provider: ServiceProviderType, shot: Shot) {
    self.likeButtonViewModel = ReactionLikeButtonViewModel(provider: provider, shot: shot)
    self.commentButtonViewModel = ReactionCommentButtonViewModel(provider: provider, shot: shot)
  }
  
}
