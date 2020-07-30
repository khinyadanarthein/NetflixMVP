//
//  MockMovieApiClient.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 29/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
@testable import NetflixMVP
@testable import RxSwift

class MockMovieApiClient : XCTestCase {
    static let shared:MockMovieApiClient = MockMovieApiClient()
    
    //private override init() {}
    
}

extension MockMovieApiClient : MovieApi {
    
    func getMovies(status: String) -> Observable<GetAllMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "rated_movie_result")
                
                let data:GetAllMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
        
    }
    
    func getTrendingMovies(page: Int) -> Observable<GetTrendingMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "trending_result")
                XCTAssertNotNil(response)
                
                let data:GetTrendingMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getNowPlayingMovies(page: Int) -> Observable<GetNowPlayMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "now_playing_list_result")
                XCTAssertNotNil(response)
                
                let data:GetNowPlayMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getUpcomingMovies(page: Int) -> Observable<GetUpcomingMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "upcoming_list_result")
                XCTAssertNotNil(response)
                
                let data:GetUpcomingMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getTopRatedMovies(page: Int) -> Observable<GetTopRatedMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "top_rated_list_result")
                XCTAssertNotNil(response)
                
                let data:GetTopRatedMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getMovieDetail(id: Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "movie_detail_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(MovieDetailVO.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "movie_video_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(MovieVideoVO.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func addMovieToRated(id: Int, sessionId: String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "rated_movie_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(UpdateResponse.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func addMovieToWatched(userId: Int, movieId: Int, sessionId: String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "rated_movie_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(UpdateResponse.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getSimilarMoviesById(id: Int, page: Int) -> Observable<SimilarMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "similar_movies_result")
                XCTAssertNotNil(response)
                
                let data:SimilarMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func searchMovies(movieName: String) -> Observable<SearchMovieResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "search_result")
                XCTAssertNotNil(response)
                
                let data:SearchMovieResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func requestToken(apiKey: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "request_token_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(RequestTokenResponse.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func loginWithToken(id: String, password: String, token: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "login_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(RequestTokenResponse.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "get_session_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(GetSessionResponse.self, from: response)
            success(data.sessionId)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getAccount(sessionId: String, success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: "account_detail_result")
            XCTAssertNotNil(response)
            
            let data = try! JSONDecoder().decode(AccountDetailResponse.self, from: response)
            success(data)
            
        }catch let ex {
            debugPrint(ex.localizedDescription)
            fail(ex.localizedDescription)
        }
    }
    
    func getProfileDetail(sessionId: String) -> Observable<AccountDetailResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "account_detail_result")
                XCTAssertNotNil(response)
                
                let data:AccountDetailResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getRateMovies(sessionId: String, accountId: String) -> Observable<RateMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "user_rated_list_result")
                XCTAssertNotNil(response)
                
                let data:RateMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getWatchMovies(sessionId: String, accountId: String) -> Observable<WatchMoviesResponse> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "user_watched_list_result")
                XCTAssertNotNil(response)
                
                let data:WatchMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    

}
