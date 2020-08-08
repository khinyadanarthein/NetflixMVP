//
//  MockDataImpl.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 15/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
import XCTest
@testable import NetflixMVP

/**


Mock Object သည် TestCase မဟုတ်ပါ။
For Example,
class MockDataModelImpl: DataModel {}


Test လုပ်မယ့် Class File သာလျှင် XCTestCase ကို extends လုပ်သင့်
For Example,
class TestDataModel: XCTestCase {}


*/


struct MockError: Error {
    var localizedDescription: String = "Sample Error Message"
}

class MockDataModelImpl : XCTestCase {

    static let shared:MockDataModelImpl = MockDataModelImpl()
    let mockApi:MovieApi = MockMovieApiClient()
    let mockdb :Dao = MockRealmHelper.shared
    let bag:DisposeBag = DisposeBag()
    var shouldReturnErrorData = false
}
extension MockDataModelImpl : DataModel {
    
    //========================= HOME =========================//
    //MARK : --- Home
    func getTrendingMoviesFromAPI(page: Int) {
        _ = mockApi.getTrendingMovies(page: page)
            .flatMap{ response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 1000)
                return self.mockdb.saveTrendingMovies(data: response.results)
                
            }
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getNowPlayingMoviesFromAPI(page: Int) {
        _ = mockApi.getNowPlayingMovies(page: page)
            .flatMap{response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 624)
                return self.mockdb.saveNowPlayingMovies(data: response.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getUpcomingMoviesFromAPI(page: Int) {
        _ = mockApi.getUpcomingMovies(page: page)
            .flatMap{response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 1000)
                return self.mockdb.saveUpcomingMovies(data: response.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getTopRatedMoviesFromAPI(page: Int) {
        _ = mockApi.getTopRatedMovies(page: page)
            .flatMap{response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 7570)
                return self.mockdb.saveTopRatedMovies(data: response.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getTrendingMovies() -> Observable<[TrendingMovieVO]> {
        let data = mockdb.getTrendingMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getNowPlayingMovies() -> Observable<[NowPlayingMovieVO]> {
        let data = mockdb.getNowShowingMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]> {
        let data = mockdb.getUpcomingMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]> {
        let data = mockdb.getTopRatedMovies()
        XCTAssertNotNil(data)
        return data
    }
    
    //========================= DETAIL =========================//
    
//    func getMovieById(id: Int) -> Observable<MovieDetailVO> {
//        mockdb.getMovieById(id: id)
//    }
    
    func getMovieDetail(id: Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        return mockApi.getMovieDetail(id: id, success: { (data) in
            XCTAssertEqual(data.id, 547016)
            XCTAssertEqual(data.backdropPath, "/m0ObOaJBerZ3Unc74l471ar8Iiy.jpg")
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void) {
        
        XCTAssertEqual(id, 547016)
        return mockApi.getMovieVideo(id: id, success: { (data) in
            XCTAssertEqual(data.id, "547016")
            XCTAssertEqual(data.key, "aK-X2d0lJ_s")
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getSimilarMovie(id: Int) {
        _ = mockApi.getSimilarMoviesById(id: id, page: 1)
            .flatMap{response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 20)
                XCTAssertEqual(response.totalResults, 1087)
                return self.mockdb.saveSimilarMovies(data: response.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getSimilarMovieObservable() -> Observable<[SimilarMovieVO]> {
        if shouldReturnErrorData {
            return Observable.create { (observer) -> Disposable in
                observer.onError(MockError())
                observer.onCompleted()
                return Disposables.create()
            }
        } else {
            let data = mockdb.getSimilarMovies()
            XCTAssertNotNil(data)
            return data
        }
    }
    
    func deleteSimilarMovie() {
        mockdb.deleteOldSimilarMovies()
    }
    
    func addMovieToRatedList(id: Int, sessionId: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        mockApi.addMovieToRated(id: id, sessionId: sessionId, success: { (data) in
            XCTAssertEqual(data.statusCode, 12)
            if data.statusCode == 12 {
                success(data.statusMessage)
            }
            fail(data.statusMessage)
            
        }) { (error) in
            fail(error)
        }
    }
    
    func addMovieToWatchedList(userId: Int, movieId: Int, sessionId: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        mockApi.addMovieToWatched(userId: userId, movieId: movieId, sessionId: sessionId, success: { (data) in
            XCTAssertEqual(data.statusCode, 12)
            if data.statusCode == 12 {
                success(data.statusMessage)
            } else {
                fail(data.statusMessage)
            }
        }) { (error) in
            fail(error)
        }
    }
    
    //========================= SEARCH =========================//
    
    func searchMovie(movieName: String) -> Observable<[SearchMovieVO]> {
        mockApi.searchMovies(movieName: movieName)
            .map{ movieResponse in
                XCTAssertEqual(movieResponse.results.count, 5)
                return movieResponse.results
        }
            .catchError { (error) -> Observable<[SearchMovieVO]> in
                debugPrint(error.localizedDescription)
                return Observable.just([SearchMovieVO]())
        }
    }
    
    //========================= LOGIN =========================//
    func requestToken(apiKey: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        mockApi.requestToken(apiKey: apiKey,success: { (data) in
            
            UserDefaultUtil.shared.saveToken(token: data.requestToken)
            XCTAssertEqual(data.requestToken, "cb0d71050ac809b69ff9b0e42093ff0718af2b15")
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    func loginWithToken(username: String, password: String, token : String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        
        mockApi.loginWithToken(id: username, password: password ,token: token, success: { (data) in
            
            UserDefaultUtil.shared.saveUserName(userName: username)
            UserDefaultUtil.shared.savePassword(userName: password)
            XCTAssertEqual(data.requestToken, "cb0d71050ac809b69ff9b0e42093ff0718af2b15")
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        mockApi.getSessionID(token: token, success: { (sessionID) in
            UserDefaultUtil.shared.saveSessionID(token: sessionID)
            XCTAssertEqual(sessionID, "67c0ce1a06d19346032c4326d2c098cb45b3a333")
            success(sessionID)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    //========================= Profile =========================//
    
    func getAccoundtDetail(sessionId: String, success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void) {
        mockApi.getAccount(sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (data) in
            UserDefaultUtil.shared.saveUserId(userId: data.id)
            UserDefaultUtil.shared.saveUserName(userName: data.username)
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    func getRatedMovies(sessionId: String, accountId: String) {
        _ = mockApi.getRateMovies(sessionId: sessionId, accountId: accountId)
            .flatMap{response -> Observable<Bool> in
                XCTAssertEqual(response.results.count, 5)
                XCTAssertEqual(response.totalResults, 5)
                return self.mockdb.saveRatedMovies(data: response.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getWatchMovies(sessionId: String, accountId: String) {
        _ = mockApi.getWatchMovies(sessionId: sessionId, accountId: accountId)
        .flatMap{response -> Observable<Bool> in
            XCTAssertEqual(response.results.count, 7)
            XCTAssertEqual(response.totalResults, 7)
            return self.mockdb.saveWatchedMovies(data: response.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getAccountDetailObservable() -> Observable<AccountDetailResponse> {
        let data = mockdb.getAccountDetail()
        XCTAssertNotNil(data)
        return data
    }
    func getRatedMoviesObservable() -> Observable<[RateMovieVO]> {
        let data = mockdb.getRatedMovie()
        XCTAssertNotNil(data)
        return data
    }
    func getWatchMoviesObservable() -> Observable<[WatchMovieVO]> {
       let data = mockdb.getWatchedMovie()
        XCTAssertNotNil(data)
        return data
    }
    
    
}
