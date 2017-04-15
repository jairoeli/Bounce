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
  
}
