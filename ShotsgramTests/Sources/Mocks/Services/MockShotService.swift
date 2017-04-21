//
//  MockShotService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift
import Then

@testable import Shotsgram

final class MockShotService: BaseService, ShotServiceType, Then {
  
  func shots(paging: Paging) -> Observable<Feed<Shot>> {
    return .never()
  }
  
  func shot(id: Int) -> Observable<Shot> {
    return .never()
  }
  
  func isLiked(shotID: Int) -> Observable<Bool> {
    return .never()
  }
  
  func like(shotID: Int) -> Observable<Void> {
    return .never()
  }
  
  func unlike(shotID: Int) -> Observable<Void> {
    return .never()
  }
  
  func comments(shotID: Int) -> Observable<Feed<Comment>> {
    return .never()
  }
  
}
