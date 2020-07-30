//
//  MockSearchViewController.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
import UIKit
@testable import NetflixMVP

class TestStart: XCTestCase {

    let controller: MockSearchViewController = MockSearchViewController()
    
    override func setUp(){
        controller.mPresenter = MockSearchPresenterImpl()
    }
    func testPerformanceExample() {
        controller.test_initview()
    }

}
