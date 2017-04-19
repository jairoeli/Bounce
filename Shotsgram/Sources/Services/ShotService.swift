//
//  ShotService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

protocol ShotServiceType {
  func shots(paging: Paging) -> Observable<Feed<Shot>>
  func shot(id: Int) -> Observable<Shot>
}

final class ShotService: BaseService, ShotServiceType {
  
  func shots(paging: Paging) -> Observable<Feed<Shot>> {
    let api: DribbbleAPI
    
    switch paging {
      case .refresh: api = .shots
      case .next(let url): api = .url(url)
    }
    
    return self.provider.networking.request(api).map(Feed<Shot>.self)
  }
  
  func shot(id: Int) -> Observable<Shot> {
    return self.provider.networking.request(.shot(id: id)).map(Shot.self)
  }
  
}
