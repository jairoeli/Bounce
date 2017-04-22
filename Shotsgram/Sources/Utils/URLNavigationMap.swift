//
//  URLNavigationMap.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit
import URLNavigator

final class URLNavigationMap {
  
  static func initialize(provider: ServiceProviderType) {
    Navigator.map("bounce://oauth/callback") { url, values in
      guard let code = url.queryParameters["code"] else { return false }
      provider.authService.callback(code: code)
      return true
    }
  }
  
}
