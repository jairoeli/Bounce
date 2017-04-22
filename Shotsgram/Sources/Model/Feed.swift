//
//  Feed.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation

struct Feed<Element> {
  var items: [Element]
  var nextURL: URL?
  
  init(items: [Element], nextURL: URL? = nil) {
    self.items = items
    self.nextURL = nextURL
  }
}
