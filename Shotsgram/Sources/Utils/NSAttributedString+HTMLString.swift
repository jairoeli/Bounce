//
//  NSAttributedString+HTMLString.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

enum HTMLStringError: Error {
  case invalidData
  case underlying(Error)
}

extension NSAttributedString {
  
  convenience init(htmlString: String, fontFamily: String = "-apple-system", fontSize: CGFloat = UIFont.systemFontSize) throws {
    let styleTagString = NSAttributedString.style(font: fontFamily, size: fontSize)
    let htmlString = styleTagString + htmlString
    
    guard let data = htmlString.data(using: .utf8) else { throw HTMLStringError.invalidData }
    
    let options: [String: Any] = [
      NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
      NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
    ]
    
    do {
      try self.init(data: data, options: options, documentAttributes: nil)
    } catch let error {
      throw HTMLStringError.underlying(error)
    }
    
  }
  
  private class func style(font family: String, size: CGFloat) -> String {
    return "<style>body{font-family: '\(family)';font-size: \(size)px;}</style>"
  }
  
}
