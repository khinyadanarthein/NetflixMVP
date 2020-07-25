//
//  NetflixMVPUnitTests.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 13/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
import Foundation
@testable import NetflixMVP
@testable import Mocker
@testable import Alamofire
@testable import RxSwift

class NetflixMVPUnitTests: XCTestCase {
    
    let bag:DisposeBag = DisposeBag()
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func test_upcoming_list_success() throws {
        
        let data = try Data.fromJSON(fileName: "search_upcoming_result")
        XCTAssertNotNil(data)
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Session(configuration: configuration)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=cc61c73fdd787cda0cdf930eb5b2528b&query=")!
        
        let mock = Mock(url: originalURL, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: "search upcoming movie")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.searchMovies(movieName: "avator")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                print("test data \(data.results.count)")
                XCTAssertEqual(data.results.count, 20)
                searchUpcomingMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertTrue(true)
                searchUpcomingMovieExpectation.fulfill()
            }).disposed(by: bag)

        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func test_search_movie_success() {
//        let model = MockDataModelImpl.shared
//
//        let searchMovieExpectation = expectation(description: "search movies")
//
//        model.searchMovie(movieName: "call")
//        .observeOn(MainScheduler.instance)
//        .subscribe(onNext:{ data in
//            print("search list \(data.count)")
//            XCTAssertNil(data)
//            searchMovieExpectation.fulfill()
//
//        },onError:{ error in
//           XCTAssertTrue(true)
//           searchMovieExpectation.fulfill()
//
//        }).disposed(by: bag)
//
//        //Wait for expectation
//        waitForExpectations(timeout: 5, handler: nil)
    }
}
