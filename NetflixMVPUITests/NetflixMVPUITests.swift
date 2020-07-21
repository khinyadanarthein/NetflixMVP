//
//  NetflixMVPUITests.swift
//  NetflixMVPUITests
//
//  Created by Khin Yadanar Thein on 14/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
@testable import NetflixMVP

class NetflixMVPUITests: XCTestCase {

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    // First Time Login
    func test_go_to_login_page_success() {
        let app = XCUIApplication()
        app.launch()
        
        // Navigate to Login Page
        app.buttons["Profile"].tap()
        
        //Instantiate storyboard
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        XCTAssertNotNil(storyboard, "Target storyboard should be present")
         //Instantiate viewcontroller
//        let viewcontroller = storyboard.instantiateViewController(identifier:
//        "LoginViewController") as? LoginViewController
        //Assert that viewcontroller is fully loaded
//        XCTAssertNotNil(viewcontroller, "Viewcontroller should be present")
                
        let loginID = app.otherElements.textFields["User Name"]
        loginID.tap()
        loginID.typeText("JuJue_KYT")
        
    }
}
