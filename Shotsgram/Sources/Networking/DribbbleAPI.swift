//
//  DribbbleAPI.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Moya
import MoyaSugar

enum DribbbleAPI {
  case url(URL)
  case me
  case shots
  case shot(id: Int)
  case isLiked(id: Int)
  case likeShot(id: Int)
  case unlikeShot(id: Int)
  case shotComments(shotID: Int)
}

extension DribbbleAPI: SugarTargetType {
  
  var baseURL: URL {
    return URL(string: "https://api.dribbble.com/v1")!
  }
  
  var url: URL {
    switch self {
      case .url(let url): return url
      default: return self.defaultURL
    }
  }
  
  var route: Route {
    switch self {
      case .url: return .get("")
      case .me: return .get("/user")
      case .shots: return .get("/shots")
      case let .shot(id): return .get("/shots/\(id)")
      case let .isLiked(id): return .get("/shots/\(id)/like")
      case let .likeShot(id): return .post("/shots/\(id)/like")
      case let .unlikeShot(id): return .delete("/shots/\(id)/like")
      case let .shotComments(shotID): return .get("/shots/\(shotID)/comments")
    }
  }
  
  var params: Parameters? {
    switch self {
      case .shots: return ["per_page": 100]
      default: return nil
    }
  }
  
  var task: Task {
    switch self {
      default: return .request
    }
  }
  
  var httpHeaderFields: [String : String]? {
    return ["Accept": "application/json"]
  }
  
  var sampleData: Data {
    return Data()
  }
  
}
