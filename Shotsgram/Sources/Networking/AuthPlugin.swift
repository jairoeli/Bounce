//
//  AuthPlugin.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Moya

struct AuthPlugin: PluginType {

  fileprivate let provider: ServiceProviderType

  init(provider: ServiceProviderType) {
    self.provider = provider
  }

  func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
    var request = request

    if let accessToken = self.provider.authService.currentAccessToken?.accessToken {
      request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }

    return request
  }

}
