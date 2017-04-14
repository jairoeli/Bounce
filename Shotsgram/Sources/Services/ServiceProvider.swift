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
}


final class ServiceProvider: ServiceProviderType {
  let networking = Networking<DribbbleAPI>()
  lazy var authService: AuthServiceType = AuthService(provider: self)
}
