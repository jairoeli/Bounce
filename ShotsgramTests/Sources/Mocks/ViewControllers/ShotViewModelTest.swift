//
//  ShotViewModelTest.swift
//  Shotsgram
//
//  Created by Jairo Eli de Leon on 4/21/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import XCTest
import RxCocoa
import RxExpect
import RxSwift
import RxTest

@testable import Shotsgram

final class ShotViewModelTests: XCTestCase {
  
  func TestIsRefreshing() {
    RxExpect { test in
      let provider = MockServiceProvider()
      let viewModel = ShotViewModel(provider: provider, shotID: 1)
      
      test.input(viewModel.refresh, [next(100, Void()), next(200, Void())])
      test.assert(viewModel.isRefreshing)
        .filterNext()
        .equal([
          false, // initial
          true,  // first refresh
          false, // refresh finish
          true,  // second refresh
          false, // refresh finish
        ])
    }
  }
  
  func testSections() {
    
    RxExpect { test in
      let provider = MockServiceProvider()
      provider.shotService = MockShotService(provider: provider).then {
        $0.shotClosure = { _ in .just(ShotFixture.shot1) }
      }
      
      let viewModel = ShotViewModel(provider: provider, shotID: 1)
      test.input(viewModel.refresh, [next(100, Void())])
      
      let isShotSectionItemsEmpty = viewModel.sections.map { $0.first?.items.isEmpty ?? true }
      test.assert(isShotSectionItemsEmpty)
        .filterNext()
        .equal([
          true, //  initial
          false, // after refresh
        ])
    }
    
  }
  
}
