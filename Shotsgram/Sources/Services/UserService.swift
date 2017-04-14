//
//  UserService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxSwift

protocol UserServiceType {
  var currentUser: Observable<User?> { get }
  
  func fetchMe() -> Observable<Void>
}

final class UserService: BaseService, UserServiceType {
  
  fileprivate let userSubject = PublishSubject<User?>()
  lazy var currentUser: Observable<User?> = self.userSubject.asObservable()
  
  func fetchMe() -> Observable<Void> {
    return self.provider.networking.request(.me)
      .map(User.self)
      .do(onNext: { [weak self] user in
        self?.userSubject.onNext(user)
      })
      .map { _ in Void() }
  }
  
}
