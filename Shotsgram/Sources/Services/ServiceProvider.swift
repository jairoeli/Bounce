//
//  ServiceProvider.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

protocol ServiceProviderType: class {
  var authService: AuthServiceType { get }
}


final class ServiceProvider: ServiceProviderType {
  lazy var authService: AuthServiceType = AuthService(provider: self)
}
