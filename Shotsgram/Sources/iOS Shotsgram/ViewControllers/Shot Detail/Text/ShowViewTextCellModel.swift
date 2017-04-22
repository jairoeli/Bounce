//
//  ShowViewTextCellModel.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

protocol ShotViewTextCellModelType {
  var text: NSAttributedString? { get }
}

final class ShotViewTextCellModel: ShotViewTextCellModelType {
  let text: NSAttributedString?
  
  init(provider: ServiceProviderType, shot: Shot) {
    if let text = shot.text {
      self.text = try? NSAttributedString(htmlString: text)
    } else {
      self.text = nil
    }
  }
}
