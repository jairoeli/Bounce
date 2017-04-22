//
//  UITableView+Rx.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift

extension Reactive where Base: UITableView {
  
  func itemSelected<S: SectionModelType>(dataSource: TableViewSectionedDataSource<S>) -> ControlEvent<S.Item> {
    let source = self.itemSelected.map { indexPath in dataSource[indexPath] }
    return ControlEvent(events: source)
  }
  
}
