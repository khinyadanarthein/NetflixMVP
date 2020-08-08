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


/**
 
 Test Case တိုင်းအတွက် Object Instantiation ပြန်ရေးဖို့မလို => Refactor လုပ်လို့ရ
 Check DetailPresenterImplTest.swift file for reference
 
 */


class NetflixMVPUnitTests: XCTestCase {
    
    let bag:DisposeBag = DisposeBag()
    
    //var sessionManager : Session!
    
    func test_upcoming_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "upcoming_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: "upcoming movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getUpcomingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 20)
                searchUpcomingMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_upcoming_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "upcoming_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchUpcomingMovieExpectation = expectation(description: "upcoming movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getUpcomingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                print("testing ==========")
                XCTAssertEqual(data.results.count, 0)
            },onError:{ error in
                print("error ==========")
                XCTAssertNotNil(error)
                searchUpcomingMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_trending_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "trending_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let trendingMovieExpectation = expectation(description: "trending movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getTrendingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 20 )
                trendingMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_trending_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "trending_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let trendingMovieExpectation = expectation(description: "trending movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getTrendingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 0)
            },onError:{ error in
                XCTAssertNotNil(error)
                trendingMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_now_playing_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "now_playing_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let nowPlayingMovieExpectation = expectation(description: "now playing movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getNowPlayingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 20 )
                nowPlayingMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_now_playing_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "now_playing_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let nowPlayingMovieExpectation = expectation(description: "now playing movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getNowPlayingMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 0)
            },onError:{ error in
                XCTAssertNotNil(error)
                nowPlayingMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_top_rated_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "top_rated_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let topRatedMovieExpectation = expectation(description: "top rated movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getTopRatedMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 20 )
                topRatedMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_top_rated_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "top_rated_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let topRatedMovieExpectation = expectation(description: "top rated movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.getTopRatedMovies(page: 1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                XCTAssertEqual(data.results.count, 0)
            },onError:{ error in
                XCTAssertNotNil(error)
                topRatedMovieExpectation.fulfill()
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_search_movie_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "search_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=cc61c73fdd787cda0cdf930eb5b2528b&query=")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchMovieExpectation = expectation(description: "search upcoming movie")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.searchMovies(movieName: "the wild life")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                print("test data \(data.results.count)")
                XCTAssertEqual(data.results.count, 5)
                searchMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_search_movie_success_no_result() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "search_no_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=cc61c73fdd787cda0cdf930eb5b2528b&query=")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let searchMovieExpectation = expectation(description: "search upcoming movie")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        
        MovieApiClient.shared.searchMovies(movieName: "asdfjkl")
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                print("test data \(data.results.count)")
                XCTAssertEqual(data.results.count, 0)
                searchMovieExpectation.fulfill()
            },onError:{ error in
                XCTAssertNotNil(error)
            }).disposed(by: bag)
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_detail_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getMovieDetail(id: 547016, success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNotNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_detail_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getMovieDetail(id: 547016, success: { (data) in
            XCTAssertNotNil(data)
            print("test data \(data.id)")
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_video_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_video_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/videos?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie video")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getMovieVideo(id: 547016, success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNotNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_video_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "movie_video_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/videos?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie video")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getMovieVideo(id: 547016, success: { (data) in
            XCTAssertNotNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_movie_similar_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "similar_movies_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/similar?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "similar movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getSimilarMoviesById(id: 547016, page: 1).observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 20)
            similarMovieExpectation.fulfill()
        },onError:{ error in
            XCTAssertNotNil(error)
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    
    func test_get_movie_similar_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "similar_movies_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/similar?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "movie detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getSimilarMoviesById(id: 547016, page: 1).observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 0)
        },onError:{ error in
            XCTAssertNotNil(error)
            similarMovieExpectation.fulfill()
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_movie_rated_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "rated_movie_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/rating?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c&value=5.0")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.addMovieToRated(id: 547016, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNotNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_movie_rated_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "rated_movie_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/movie/547016/rating?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c&value=5.0")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "movie rated")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.addMovieToRated(id: 547016, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa262", success: { (data) in
            XCTAssertNotNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_add_movie_watched_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "rated_movie_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/watchlist?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=bd61607a01ba01f0b576bf7bd772cbcbe911a6dd&media_type=movie&media_id=547016&watchlist=true")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "add movie watched")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.addMovieToWatched(userId: 9282485, movieId: 547016, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNotNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_add_movie_watched_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "rated_movie_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/watchlist?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=bd61607a01ba01f0b576bf7bd772cbcbe911a6dd&media_type=movie&media_id=547016&watchlist=true")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "add movie watched")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.addMovieToWatched(userId: 9282485, movieId: 547016, sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26ca", success: { (data) in
            XCTAssertNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_request_token_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "request_token_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=cc61c73fdd787cda0cdf930eb5b2528b")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "request token")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.requestToken(apiKey: API_KEY,success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }

     func test_request_token_failed() throws {
         
         let configuration = URLSessionConfiguration.af.default
         configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
         
         let sessionManager = Alamofire.Session(configuration: configuration)
         
         let data = try Data.fromJSON(fileName: "request_token_result")
         XCTAssertNotNil(data)
         
         let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=cc61c73fdd787cda0cdf930eb5b2528b")!
         
         let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 403, data: [Mock.HTTPMethod.get : data])
         mock.register()
         
         let movieDetailExpectation = expectation(description: "request token")
         
         MovieApiClient.shared.setNetworkClient(session: sessionManager)
         MovieApiClient.shared.requestToken(apiKey: API_KEY, success: { (data) in
             XCTAssertNil(data)
         }) { (error) in
              XCTAssertNotNil(error)
              movieDetailExpectation.fulfill()
         }
         
         //Wait for expectation
         waitForExpectations(timeout: 5, handler: nil)
     }
    
    func test_login_with_token_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "login_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=cc61c73fdd787cda0cdf930eb5b2528b&username=JuJue_KYT&password=611993&request_token=cb0d71050ac809b69ff9b0e42093ff0718af2b15")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "login with token")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.loginWithToken(id: "JuJue_KYT", password: "611993", token: "cb0d71050ac809b69ff9b0e42093ff0718af2b15", success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_login_with_token_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "login_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=cc61c73fdd787cda0cdf930eb5b2528b&username=JuJue_KYT&password=611993&request_token=cb0d71050ac809b69ff9b0e42093ff0718af2b15")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "login with token")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.loginWithToken(id: "JuJue_KYT", password: "611993", token: "cb0d71050ac809b69ff9b0e42093ff0718af2b15", success: { (data) in
            XCTAssertNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_session_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "get_session_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=cc61c73fdd787cda0cdf930eb5b2528b&request_token=cb0d71050ac809b69ff9b0e42093ff0718af2b15")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "request session id")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getSessionID(token: "cb0d71050ac809b69ff9b0e42093ff0718af2b15", success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_session_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "get_session_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/authentication/session/new?api_key=cc61c73fdd787cda0cdf930eb5b2528b&request_token=cb0d71050ac809b69ff9b0e42093ff0718af2b15")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.post : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "request session id")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getSessionID(token: "cb0d71050ac809b69ff9b0e42093ff0718af2b15", success: { (data) in
            XCTAssertNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_account_detail_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "account_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "request account detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getAccount(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (data) in
            XCTAssertNotNil(data)
            movieDetailExpectation.fulfill()
        }) { (error) in
             XCTAssertNil(error)
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_account_detail_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "account_detail_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let movieDetailExpectation = expectation(description: "request account detail")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getAccount(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", success: { (data) in
            XCTAssertNil(data)
        }) { (error) in
             XCTAssertNotNil(error)
             movieDetailExpectation.fulfill()
        }
        
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_user_rated_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "user_rated_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/rated/movies?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c&sort_by=created_at.asc&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "rated movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getRateMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", accountId: "9282485").observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 5)
            similarMovieExpectation.fulfill()
        },onError:{ error in
            XCTAssertNotNil(error)
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_user_rated_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "user_rated_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/rated/movies?api_key=cc61c73fdd787cda0cdf930eb5b2528b&language=en-US&session_id=edb7a81aa8c306c5a2ae06535146d5886adfa26c&sort_by=created_at.asc&page=1")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "rated movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getRateMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", accountId: "9282485").observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 0)
        },onError:{ error in
            XCTAssertNotNil(error)
            similarMovieExpectation.fulfill()
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_get_user_watched_list_success() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "user_watched_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/watchlist/movies?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=bd61607a01ba01f0b576bf7bd772cbcbe911a6dd")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 200, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "watched movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getWatchMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", accountId: "9282485").observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 7)
            similarMovieExpectation.fulfill()
        },onError:{ error in
            XCTAssertNotNil(error)
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func test_get_user_watched_list_failed() throws {
        
        let configuration = URLSessionConfiguration.af.default
        configuration.protocolClasses = [MockingURLProtocol.self] + (configuration.protocolClasses ?? [])
        
        let sessionManager = Alamofire.Session(configuration: configuration)
        
        let data = try Data.fromJSON(fileName: "user_watched_list_result")
        XCTAssertNotNil(data)
        
        let originalURL = URL(string: "https://api.themoviedb.org/3/account/9282485/watchlist/movies?api_key=cc61c73fdd787cda0cdf930eb5b2528b&session_id=bd61607a01ba01f0b576bf7bd772cbcbe911a6dd")!
        
        let mock = Mock(url: originalURL, ignoreQuery: true, dataType: .json, statusCode: 500, data: [Mock.HTTPMethod.get : data])
        mock.register()
        
        let similarMovieExpectation = expectation(description: "watched movie list")
        
        MovieApiClient.shared.setNetworkClient(session: sessionManager)
        MovieApiClient.shared.getWatchMovies(sessionId: "edb7a81aa8c306c5a2ae06535146d5886adfa26c", accountId: "9282485").observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            print("test data \(data.results.count)")
            XCTAssertEqual(data.results.count, 0)
        },onError:{ error in
            XCTAssertNotNil(error)
            similarMovieExpectation.fulfill()
        }).disposed(by: bag)
        //Wait for expectation
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
