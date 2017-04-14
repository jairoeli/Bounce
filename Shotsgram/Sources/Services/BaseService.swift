//
//  BaseService.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/13/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

class BaseService {
  unowned let provider: ServiceProviderType
  
  init(provider: ServiceProviderType) {
    self.provider = provider
  }
}
