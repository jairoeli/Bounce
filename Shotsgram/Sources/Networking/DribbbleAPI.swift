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
  case shots
}

extension DribbbleAPI: SugarTargetType {
  
  var baseURL: URL {
    return URL(string: "https://api.dribbble.com/v1")!
  }
  
  var route: Route {
    switch self {
      case .shots: return .get("/shots")
    }
  }
  
  var params: Parameters? {
    switch self {
      default: return nil
    }
  }
  
  var task: Task {
    switch self {
      default: return .request
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
}
