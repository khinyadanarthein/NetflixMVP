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

    let app = XCUIApplication()
    
    func test_tab_bar_button_navigate_success() {
        app.launch()
    }
    
    /**
        test for navigation of Search screen
     */
    func test_navigate_to_home_screen() {
        app.launch()
        app.buttons["Home"].tap()
        let trendCollectionView = app.collectionViews.element(boundBy: 0)
        if trendCollectionView.cells.count > 0 {
            trendCollectionView.cells.element(boundBy: 0).tap()
            close_detail_page_success()
        }

        let nowPlayCollectionView = app.collectionViews.element(boundBy: 1)
        if nowPlayCollectionView.cells.count > 0 {
            nowPlayCollectionView.cells.element(boundBy: 0).tap()
            close_detail_page_success()
        }

        let table = app.tables.element(boundBy: 0)
        let tableBottom = table.coordinate(withNormalizedOffset:CGVector(dx: 0.5, dy: 1.0))
        // Scroll from tableBottom to new coordinate
        let scrollVector = CGVector(dx: 0.0, dy: -30.0) // Use whatever vector you like
        tableBottom.press(forDuration: 0.5, thenDragTo: tableBottom.withOffset(scrollVector))
        
        let upcomingCollectionView = app.collectionViews.element(boundBy: 2)
        if upcomingCollectionView.cells.count > 0 {
            upcomingCollectionView.cells.element(boundBy: 0).tap()
            close_detail_page_success()
        }
        sleep(2)
        let topRatedCollectionView = app.collectionViews.element(boundBy: 3)
        if topRatedCollectionView.cells.count > 0 {
            topRatedCollectionView.cells.element(boundBy: 3).tap()
            close_detail_page_success()
        }
        
    }
    
    /**
        test for navigation of Search screen
     */
    func test_navigate_to_search_screen() {
        app.launch()
        app.buttons["Search"].tap()
        let searchText = app.textFields["movieName"]
        searchText.tap()
        searchText.typeText("L")
        sleep(5)
        
        if app.collectionViews.cells.count > 0 {
            let collectionCell = app.collectionViews.cells.element(boundBy: 0)
            collectionCell.tap()
            sleep(2)
            add_watch_list_success()
            close_detail_page_success()
        }
        
    }
    
    /**
        test for navigation of Profile / Login
     */
    func test_navigate_to_profile_screen() {
        app.launch()
        app.buttons["Profile"].tap()
        
        // if first time login, test for login screen navigate
        if app.navigationBars.element.identifier == "Login" {
            test_fill_login_data_failed(id: "Jue", password: "123456")
            
            test_fill_login_data_success(id: "JuJue_KYT", password: "611993")
        }
            
        //if already login, test for profile screen navigate
        else {
            test_watch_list_cell_click()
            test_rated_list_cell_click()
        }
        
    }
    /**
        test for login failed process
     */
    func test_fill_login_data_failed(id : String, password : String) {
        let loginID = app.textFields["username"]
        loginID.tap()
        loginID.typeText(id)
        
        sleep(3)
        let pwd = app.secureTextFields["password"]
        pwd.tap()
        pwd.typeText(password)
        
        app.buttons["Sign In"].tap()
        
        sleep(2)
        let alert = app.alerts["Login Error"]
        XCTAssertNotNil(alert)
        alert.buttons["OK"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Login")
    }
    /**
       test for login success process
    */
    func test_fill_login_data_success(id : String, password : String) {
        let loginID = app.textFields["username"]
        loginID.tap()
        
        if let id = loginID.value as? String {
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: id.count)
            loginID.typeText(deleteString)
            
        }
        loginID.typeText(id)
        
        sleep(2)
        let pwd = app.secureTextFields["password"]
        pwd.tap()
        pwd.typeText(password)
        
        app.buttons["Sign In"].tap()
        
        sleep(3)
        XCTAssertNotEqual(app.navigationBars.element.identifier, "Login")
        XCTAssertEqual(app.navigationBars.element.identifier, "Profile")
        
    }
    /**
       watch list cell click success
    */
    func test_watch_list_cell_click() {
        let watchCollectionView = app.collectionViews.element(boundBy: 0)
        let cell = watchCollectionView.cells
        sleep(2)
        cell.element(boundBy: 0).tap()
        sleep(2)
        close_detail_page_success()
    }
    /**
       rated list cell click success
    */
    func test_rated_list_cell_click() {
        let ratedCollectionView = app.collectionViews.element(boundBy: 1)
        let cell = ratedCollectionView.cells
        sleep(2)
        cell.element(boundBy: 0).tap()
        sleep(2)
        close_detail_page_success()
    }
    
    /**
          detail screen add watch list success
    */
    func add_watch_list_success() {
        XCTAssertNotNil(app.scrollViews.otherElements.otherElements["myList"])
        app.scrollViews.otherElements.otherElements["myList"].tap()
        
        sleep(6)
        close_detail_page_success()
    }
    
    /**
          detail screen add watch list success
    */
    func add_rated_list_success() {
        XCTAssertNotNil(app.scrollViews.otherElements.otherElements["rateMovie"])
        app.scrollViews.otherElements.otherElements["myList"].tap()
        
        sleep(6)
        close_detail_page_success()
        
    }
    
    /**
         close detail screen success
    */
    func close_detail_page_success() {
        sleep(2)
        XCTAssertNotNil(app.images["closeDetailBtn"])
        app.images["closeDetailBtn"].tap()
        sleep(2)
    }
}
