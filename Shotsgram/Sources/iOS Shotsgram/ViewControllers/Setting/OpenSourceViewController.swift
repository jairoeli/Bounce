//
//  OpenSourceViewController.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class OpenSourceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var tableView: UITableView = UITableView()
  let cellId = "cellId"
  
  let items = [
    "Alamofire",
    "Moya/RxSwift",
    "MoyaSugar/RxSwift",
    "WebLinking",
    "Kingfisher",
    "ObjectMapper",
    "RxSwift",
    "RxSwift",
    "RxCocoa",
    "RxDataSources",
    "RxOptional",
    "RxKeyboard",
    "RxSwiftUtilities",
    "RxReusable",
    "RxGesture",
    "SnapKit",
    "ManualLayout",
    "Immutable",
    "CocoaLumberjack/Swift",
    "Then",
    "ReusableKit",
    "CGFloatLiteral",
    "SwiftyColor",
    "SwiftyImage",
    "UITextView+Placeholder",
    "URLNavigator",
    "KeychainAccess"
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Software Libraries"
    
    tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    self.view.addSubview(self.tableView)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 112, 0)
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
    cell.textLabel?.text = items[indexPath.row]
    return cell
  }
  
}
