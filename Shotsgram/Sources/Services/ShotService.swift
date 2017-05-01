//
//  ShotService.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

protocol ShotServiceType {
  func shots(paging: Paging) -> Observable<Feed<Shot>>
  func shot(id: Int) -> Observable<Shot>
  func isLiked(shotID: Int) -> Observable<Bool>
  func like(shotID: Int) -> Observable<Void>
  func unlike(shotID: Int) -> Observable<Void>
  func comments(shotID: Int) -> Observable<Feed<Comment>>
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

  func isLiked(shotID: Int) -> Observable<Bool> {
    return self.provider.networking.request(.isLiked(id: shotID)).map(true)
  }

  func like(shotID: Int) -> Observable<Void> {
    return self.provider.networking.request(.likeShot(id: shotID)).mapVoid()
  }

  func unlike(shotID: Int) -> Observable<Void> {
    return self.provider.networking.request(.unlikeShot(id: shotID)).mapVoid()
  }

  func comments(shotID: Int) -> Observable<Feed<Comment>> {
    return self.provider.networking.request(.shotComments(shotID: shotID)).map(Feed<Comment>.self)
  }

}
