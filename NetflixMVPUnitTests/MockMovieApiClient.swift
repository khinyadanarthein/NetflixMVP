//
//  MockMovieApiClient.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 29/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

/**
 Code Refactor လုပ်ထားပါတယ်။
 */


import XCTest
@testable import NetflixMVP
@testable import RxSwift

class MockMovieApiClient : MovieApi {
    
    func getMovies(status: String) -> Observable<GetAllMoviesResponse> {
        return responseData(fileName: "rated_movie_result")
    }
    
    func getTrendingMovies(page: Int) -> Observable<GetTrendingMoviesResponse> {
        return responseData(fileName: "trending_result")
    }
    
    func getNowPlayingMovies(page: Int) -> Observable<GetNowPlayMoviesResponse> {
        return responseData(fileName: "now_playing_list_result")
    }
    
    func getUpcomingMovies(page: Int) -> Observable<GetUpcomingMoviesResponse> {
        return responseData(fileName: "upcoming_list_result")
    }
    
    func getTopRatedMovies(page: Int) -> Observable<GetTopRatedMoviesResponse> {
        return responseData(fileName: "top_rated_list_result")
    }
    
    func getMovieDetail(id: Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "movie_detail_result", success: { (data: MovieDetailVO) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "movie_video_result", success: { (data: MovieVideoVO) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func addMovieToRated(id: Int, sessionId: String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "rated_movie_result", success: { (data: UpdateResponse) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func addMovieToWatched(userId: Int, movieId: Int, sessionId: String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "rated_movie_result", success: { (data: UpdateResponse) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func getSimilarMoviesById(id: Int, page: Int) -> Observable<SimilarMoviesResponse> {
        return responseData(fileName: "similar_movies_result")
    }
    
    func searchMovies(movieName: String) -> Observable<SearchMovieResponse> {
        return responseData(fileName: "search_result")
    }
    
    func requestToken(apiKey: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "request_token_result", success: { (data: RequestTokenResponse) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func loginWithToken(id: String, password: String, token: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "login_result", success: { (data: RequestTokenResponse) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "get_session_result", success: { (data: GetSessionResponse) in
            success(data.sessionId)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func getAccount(sessionId: String, success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void) {
        loadJsonData(fileName: "account_detail_result", success: { (data) in
            success(data)
        }) { (err) in
            fail(err.localizedDescription)
        }
    }
    
    func getProfileDetail(sessionId: String) -> Observable<AccountDetailResponse> {
        return responseData(fileName: "account_detail_result")
    }
    
    func getRateMovies(sessionId: String, accountId: String) -> Observable<RateMoviesResponse> {
        return responseData(fileName: "user_rated_list_result")
    }
    
    func getWatchMovies(sessionId: String, accountId: String) -> Observable<WatchMoviesResponse> {
        return responseData(fileName: "user_watched_list_result")
    }
    
    func responseData<T:Codable>(fileName: String) -> Observable<T> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: fileName)
                XCTAssertNotNil(response)
                
                let data:T? =  response.seralizeData()
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
    
    
    func loadJsonData<T:Codable>(fileName:String, success: (T) -> Void, failure: (Error) -> Void) {
        do {
            let response = try Data.fromJSON(fileName: fileName)
            XCTAssertNotNil(response)
            
            let data:T? =  response.seralizeData()
            if let data = data {
                success(data)
            } else {
                failure(FailedToParseError())
            }
        } catch let ex {
            debugPrint(ex.localizedDescription)
            failure(ex)
        }
    }
    
    struct FailedToParseError : Error {
        var localizedDescription: String = "Failed to parse data"
    }
    
}
