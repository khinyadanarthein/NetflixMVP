//
//  ModelLayerUnitTests.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 26/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
@testable import NetflixMVP
@testable import RxSwift

class ModelLayerUnitTests: XCTestCase {

    let model : DataModel = DataModelImpl.shared
    var token :String = "244c2e04381b20c7780c705fd2550b1a2f041b22"
    let userid : Int = 9282485
    let userName : String = "JuJue_KYT"
    let password : String = "611993"
    let bag : DisposeBag = DisposeBag()
    
    /*
     LOGIN
     */
    func test_login_init_success() {
        let modelExpectation = expectation(description: "request token success")
        model.requestToken(apiKey : API_KEY, success: { (requestToken) in
            XCTAssertNotNil(requestToken)
            self.token = requestToken.requestToken
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_login_init_failed() {
        let modelExpectation = expectation(description: "request token failed")
        model.requestToken(apiKey : "API_KEY", success: { (requestToken) in
            XCTAssertNotNil(requestToken)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_login_success() {
        let modelExpectation = expectation(description: "login success")
        
        model.loginWithToken(username: "JuJue_KYT", password: "611993", token: self.token, success: { (data) in
            XCTAssertTrue(data.success)
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_login_wrong_data_failed() {
        let modelExpectation = expectation(description: "login failed")
    
        model.loginWithToken(username: "JuJue_KYT", password: "6119932", token: self.token, success: { (data) in
            XCTAssertFalse(data.success)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_login_empty_failed() {
        let modelExpectation = expectation(description: "login failed")
    
        model.loginWithToken(username: "JuJue_KYT", password: "", token: self.token, success: { (data) in
            XCTAssertFalse(data.success)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_session_success() {
        let modelExpectation = expectation(description: "request session success")
        self.model.getSessionID(token: self.token, success: { (dataStr) in
            XCTAssertNotNil(dataStr)
            modelExpectation.fulfill()
            
        }) { (error) in
           XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_session_failed() {
        let modelExpectation = expectation(description: "request session failed")
        self.model.getSessionID(token: "n", success: { (dataStr) in
            XCTAssertNil(dataStr)
            
        }) { (error) in
        XCTAssertNotNil(error)
        modelExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /*
     Movie Detail
     */
    func test_movie_detail_get_similar_movies_success() {
        let modelExpectation = expectation(description: "detail init similar movies success")
        model.getSimilarMovie(id: 547016)
        model.getSimilarMovieObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertNotNil(data)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_movie_detail_get_similar_movies_no_data() {
        let modelExpectation = expectation(description: "detail init similar movies no data")
        model.getSimilarMovie(id: 1)
        model.getSimilarMovieObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.count, 0)
                modelExpectation.fulfill()
            },onError:{ error in
                XCTAssertNil(error)
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_movie_video_success() {
        let modelExpectation = expectation(description: "detail init video success")
        model.getMovieVideo(id: 547016, success: { (data) in
            XCTAssertNotNil(data)
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_movie_video_failed() {
        let modelExpectation = expectation(description: "detail init video failed")
        model.getMovieVideo(id: 0, success: { (data) in
            XCTAssertNotNil(data)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_add_rated_movie_success() {
        let modelExpectation = expectation(description: "detail rated movie success")
        model.addMovieToRatedList(id: 547017, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (message) in
            XCTAssertNotNil(message)
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_add_rated_movie_failed() {
        let modelExpectation = expectation(description: "detail rated movie failed")
        model.addMovieToRatedList(id: 0, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (message) in
            XCTAssertNil(message)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_add_watched_movie_success() {
        let modelExpectation = expectation(description: "detail watched movie success")
        model.addMovieToWatchedList(userId: 9282485, movieId: 547017, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (message) in
            XCTAssertNotNil(message)
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_add_watched_movie_failed() {
        let modelExpectation = expectation(description: "detail watched movie failed")
        model.addMovieToWatchedList(userId: 0, movieId: 0, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (message) in
            XCTAssertNil(message)
            
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /*
     Profile
     */
    
    func test_profile_init_success() {
        let modelExpectation = expectation(description: "profile init success")
        model.getAccoundtDetail(sessionId:"edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (data) in
            XCTAssertEqual(data.username ,"JuJue_KYT")
            modelExpectation.fulfill()
            
        }) { (error) in
            XCTAssertNil(error)
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_profile_init_failed() {
        let modelExpectation = expectation(description: "profile init failed")
        model.getAccoundtDetail(sessionId: "",success: { (data) in
            //navigateToMovieDetail(movie: data)
            XCTAssertNil(data)
        }) { (error) in
            XCTAssertNotNil(error)
            modelExpectation.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_profile_init_rated_list_success() {
        let modelExpectation = expectation(description: "profile init rated list success")
        model.getRatedMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c",accountId : "9282485")
        model.getRatedMoviesObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
            XCTAssertEqual(data.count , 5)
                modelExpectation.fulfill()
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_profile_init_watched_list() {
        let modelExpectation = expectation(description: "profile init watched list success")
        model.getWatchMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c",accountId: "9282485")
        model.getWatchMoviesObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.count , 7)
                modelExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    /*
     Search
     */
    func test_search_movie_success() {
        let modelExpectation = expectation(description: "search movie success")
        model.searchMovie(movieName: "the")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertNotNil(data)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_search_movie_no_data() {
        let modelExpectation = expectation(description: "search movie success no data")
        model.searchMovie(movieName: "")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.count, 0)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_home_upcoming_list_init_success() {
        
       let modelExpectation = expectation(description: "upcoming list init")
        model.getUpcomingMoviesFromAPI(page: 1)
        model.getUpcomingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
            XCTAssertNotEqual(data.count, 0)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_home_trending_list_init_success() {
        
       let modelExpectation = expectation(description: "trending list init")
        model.getTrendingMoviesFromAPI(page: 1)
        model.getTrendingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
            XCTAssertNotEqual(data.count, 0)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_home_now_playing_list_init_success() {
        
       let modelExpectation = expectation(description: "now playing list init")
        model.getNowPlayingMoviesFromAPI(page: 1)
        model.getNowPlayingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
            XCTAssertNotEqual(data.count, 0)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_home_top_rated_list_init_success() {
        
       let modelExpectation = expectation(description: "top rated list init")
        model.getTopRatedMoviesFromAPI(page: 1)
        model.getTopRatedMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertNotEqual(data.count, 0)
                modelExpectation.fulfill()
                
            },onError:{ error in
                XCTAssertNil(error)
                
            }).disposed(by: bag)
        waitForExpectations(timeout: 5, handler: nil)
    }
}
