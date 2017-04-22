//
//  MockServiceProvider.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

@testable import Bounce

final class MockServiceProvider: ServiceProviderType {
  lazy var networking: Networking<DribbbleAPI> = .init()
  lazy var authService: AuthServiceType = MockAuthService(provider: self)
  lazy var userService: UserServiceType = MockUserService(provider: self)
  lazy var shotService: ShotServiceType = MockShotService(provider: self)
}
