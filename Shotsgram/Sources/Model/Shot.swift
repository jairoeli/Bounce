//
//  Shot.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import ObjectMapper

struct Shot: ModelType {
  
  enum Event {
    case create(Shot)
    case update(Shot)
    case delete(id: Int)
    case like(id: Int)
    case unlike(id: Int)
  }
  
  var id: Int
  var title: String
  var text: String?
  var user: User
  
  var imageURLs: (hidpi: URL?, normal: URL, teaser: URL)
  var imageWidth: Int
  var imageHeight: Int
  var isAnimatedImage: Bool
  
  var viewCount: Int
  var likeCount: Int
  var commentCount: Int
  
  var createdAt: Date
  
  var isLiked: Bool?
  
  init(map: Map) throws {
    self.id = try map.value("id")
    self.title = try map.value("title")
    self.text = try? map.value("description")
    self.user = try map.value("user")
    
    self.imageURLs = (
      hidpi: try? map.value("images.hidpi", using: URLTransform()),
      normal: try map.value("images.normal", using: URLTransform()),
      teaser: try map.value("images.teaser", using: URLTransform())
    )
    
    self.imageWidth = try map.value("width")
    self.imageHeight = try map.value("height")
    self.isAnimatedImage = try map.value("animated")
    
    self.viewCount = try map.value("views_count")
    self.likeCount = try map.value("likes_count")
    self.commentCount = try map.value("comments_count")
    
    self.createdAt = try map.value("created_at", using: ISO8601DateTransform())
    
  }
  
}
