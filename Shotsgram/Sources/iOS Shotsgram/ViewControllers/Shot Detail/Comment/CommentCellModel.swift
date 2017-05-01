//
//  CommentCellModel.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/19/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

protocol CommentCellModelType {
  var avatarURL: URL? { get }
  var name: String { get }
  var message: NSAttributedString { get }
}

struct CommentCellModel: CommentCellModelType {

  let avatarURL: URL?
  let name: String
  let message: NSAttributedString

  init(provider: ServiceProviderType, comment: Comment) {
    self.avatarURL = comment.user.avatarURL
    self.name = comment.user.name
    self.message = (try? NSAttributedString(htmlString: comment.body))
      ?? NSAttributedString(string: comment.body)
  }

}
