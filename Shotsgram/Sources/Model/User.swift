//
//  User.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import ObjectMapper

struct User: ModelType {
  
  var id: Int
  var name: String
  var avatarURL: URL?
  var bio: String?
  var isPro: Bool
  
  var shotCount: Int
  var followerCount: Int
  var followingCount: Int
  
  init(map: Map) throws {
    self.id = try map.value("id")
    self.name = try map.value("name")
    self.avatarURL = try? map.value("avatar_url", using: URLTransform())
    self.bio = try? map.value("bio")
    self.isPro = try map.value("pro")
    
    self.shotCount = try map.value("shots_count")
    self.followerCount = try map.value("followers_count")
    self.followingCount = try map.value("followings_count")
  }
  
}
