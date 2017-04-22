//
//  String+Localized.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/17/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
