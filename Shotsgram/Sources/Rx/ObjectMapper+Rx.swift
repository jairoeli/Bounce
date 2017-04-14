//
//  ObjectMapper+Rx.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Moya
import ObjectMapper
import RxSwift

extension ObservableType where E == Moya.Response {
  
  func map<T: ImmutableMappable>(_ mappableType: T.Type) -> Observable<T> {
    return self.mapString().map { jsonString -> T in
      return try Mapper<T>().map(JSONString: jsonString)
    }
  }
  
  func map<T: ImmutableMappable>(_ mappableType: [T].Type) -> Observable<[T]> {
    return self.mapString().map { jsonString -> [T] in
      return try Mapper<T>().mapArray(JSONString: jsonString)
    }
  }
  
}
