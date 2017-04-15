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
    return self.mapString()
      .map { jsonString -> T in
        return try Mapper<T>().map(JSONString: jsonString)
      }
      .do(onError: { error in
        if error is MapError {
          log.error(error)
        }
      })
  }
  
  func map<T: ImmutableMappable>(_ mappableType: [T].Type) -> Observable<[T]> {
    return self.mapString()
      .map { jsonString -> [T] in
        return try Mapper<T>().mapArray(JSONString: jsonString)
      }
      .do(onError: { error in
        if error is MapError {
          log.error(error)
        }
      })
  }
  
  func map<T: ImmutableMappable>(_ mappableType: Feed<T>.Type) -> Observable<Feed<T>> {
    return self
      .map { response in
        let jsonString = try response.mapString()
        let items = try Mapper<T>().mapArray(JSONString: jsonString)
        let nextURL = (response.response as? HTTPURLResponse)?
          .findLink(relation: "next")
          .flatMap { URL(string: $0.uri) }
        return Feed<T>(items: items, nextURL: nextURL)
      }
      .do(onError: { error in
        if error is MapError {
          log.error(error)
        }
      })
  }
  
}
