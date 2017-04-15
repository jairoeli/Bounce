//
//  ServiceProvider.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

protocol ServiceProviderType: class {
  var networking: Networking<DribbbleAPI> { get }
  var authService: AuthServiceType { get }
  var userService: UserServiceType { get }
  var shotService: ShotServiceType { get }
}


final class ServiceProvider: ServiceProviderType {
  lazy var networking: Networking<DribbbleAPI> = .init(plugins: [AuthPlugin(provider: self)])
  lazy var authService: AuthServiceType = AuthService(provider: self)
  lazy var userService: UserServiceType = UserService(provider: self)
  lazy var shotService: ShotServiceType = ShotService(provider: self)
}
