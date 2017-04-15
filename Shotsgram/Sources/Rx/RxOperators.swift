//
//  RxOperators.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/14/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import RxCocoa
import RxSwift

// MARK: - isSucceeded()

extension ObservableType {
  func isSuccceed() -> Observable<Bool> {
    return self.map(true).catchErrorJustReturn(false)
  }
}

// MARK: - map()
extension ObservableType {
  func map<T>(_ element: T) -> Observable<T> {
    return self.map { _ in element }
  }
}

extension SharedSequence {
  func map<T>(_ element: T) -> SharedSequence<SharingStrategy, T> {
    return self.map { _ in element }
  }
}


// MARK: - mapVoid()
extension ObservableType {
  func mapVoid() -> Observable<Void> {
    return self.map(Void())
  }
}

extension SharedSequence {
  func mapVoid() -> SharedSequence<SharingStrategy, Void> {
    return self.map(Void())
  }
}


// MARK: - ignoreErrors()
extension ObservableType {
  func ignoreErrors() -> Observable<E> {
    return self.catchError { error -> Observable<E> in
      return .empty()
    }
  }
}


// MARK: - catchError()
extension ObservableType {
  func catchError<O: ObserverType>(_ observer: O) -> Observable<E> where O.E == Swift.Error {
    return self.catchError { error in
      observer.onNext(error)
      return .empty()
    }
  }
}
