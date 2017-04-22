//
//  ShotFeedViewModelTests.swift
//  Bounce
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import XCTest
import RxExpect
import RxCocoa
import RxSwift
import RxTest
@testable import Bounce

final class ShotFeedViewModelTests: XCTestCase {
  
  func testIsRefreshing() {
    
    RxExpect() { test in
      let provider = MockServiceProvider()
      let viewModel = ShotFeedViewModel(provider: provider)
      
      test.input(viewModel.refresh, [next(100, Void())])
      test.assert(viewModel.isRefreshing)
        .filterNext()
        .equal([false, true, false])
    }
  }
  
  func testSections() {
    
    RxExpect { test in
      let provider = MockServiceProvider()
      provider.shotService = MockShotService(provider: provider).then {
        $0.shotsClosure = { _ in
          .just(Feed(items: [ShotFixture.shot1, ShotFixture.shot2]))
        }
      }
      
      let viewModel = ShotFeedViewModel(provider: provider)
      test.input(viewModel.refresh, [next(100, Void())])
      
      let sectionItemCount = viewModel.sections.map { $0[0].items.count }
      test.assert(sectionItemCount)
        .filterNext()
        .equal([
          0,// initial
          2 // after refreshing
        ])
      
    }
    
  }
  
}
