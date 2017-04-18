//
//  UICollectionView+Rx.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/18/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift

extension Reactive where Base: UICollectionView {
  
  func itemSelected<S: SectionModelType>(dataSource: CollectionViewSectionedDataSource<S>) -> ControlEvent<S.Item> {
    let source = self.itemSelected.map { indexPath in dataSource[indexPath] }
    return ControlEvent(events: source)
  }
  
}
