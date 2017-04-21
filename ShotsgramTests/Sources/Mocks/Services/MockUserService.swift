//
//  MockUserService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift
import Then

@testable import Shotsgram

final class MockUserService: BaseService, UserServiceType, Then {
  
  var currentUser: Observable<User?> {
    return .never()
  }
  
  var fetchMeClosure: () -> Observable<Void> = { return .never() }
  
  func fetchMe() -> Observable<Void> {
    return self.fetchMeClosure()
  }
  
}
