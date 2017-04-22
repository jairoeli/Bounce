//
//  ShotFixtures.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import ObjectMapper
@testable import Bounce

struct ShotFixture {
  static let shot1 = try! Shot(JSON: [
    "id": 1,
    "title": "title1",
    "description": "description1",
    "width": 400,
    "height": 300,
    "images": [
      "hidpi": NSNull(),
      "normal": "https://example.com/shot1.png",
      "teaser": "https://example.com/shot1_teaser.png"
    ],
    "views_count": 4372,
    "likes_count": 149,
    "comments_count": 27,
    "attachments_count": 0,
    "rebounds_count": 2,
    "buckets_count": 8,
    "created_at": "2012-03-15T01:52:33Z",
    "updated_at": "2012-03-15T02:12:57Z",
    "animated": false,
    "tags": [
      "tag1",
      "tag2",
    ],
    "user": [
      "id": 123,
      "name": "Jairo Eli de Leon",
      "username": "jairoeli",
      "avatar_url": "https://example.com/jairoeli.png",
      "bio": "https://www.jairoeli.com",
      "followers_count": 29262,
      "followings_count": 1728,
      "likes_count": 34954,
      "shots_count": 214,
      "can_upload_shot": true,
      "type": "Player",
      "pro": false,
      "created_at": "2009-07-08T02:51:22Z",
      "updated_at": "2014-02-22T17:10:33Z"
    ],
    ])
  static let shot2 = try! Shot(JSON: [
    "id": 2,
    "title": "title2",
    "description": "description2",
    "width": 400,
    "height": 300,
    "images": [
      "hidpi": NSNull(),
      "normal": "https://example.com/shot2.png",
      "teaser": "https://example.com/shot2_teaser.png"
    ],
    "views_count": 4372,
    "likes_count": 149,
    "comments_count": 27,
    "attachments_count": 0,
    "rebounds_count": 2,
    "buckets_count": 8,
    "created_at": "2012-03-15T01:52:33Z",
    "updated_at": "2012-03-15T02:12:57Z",
    "animated": false,
    "tags": [
      "tag1",
      "tag2",
    ],
    "user": [
      "id": 123,
      "name": "Jairo Eli de Leon",
      "username": "jairoeli",
      "avatar_url": "https://example.com/jairoeli.png",
      "bio": "https://www.jairoeli.com",
      "followers_count": 29262,
      "followings_count": 1728,
      "likes_count": 34954,
      "shots_count": 214,
      "can_upload_shot": true,
      "type": "Player",
      "pro": false,
      "created_at": "2009-07-08T02:51:22Z",
      "updated_at": "2014-02-22T17:10:33Z"
    ],
    ])
}
