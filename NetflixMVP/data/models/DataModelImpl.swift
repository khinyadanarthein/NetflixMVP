//
//  DataModelImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class DataModelImpl: DataModel {
    
    static let shared:DataModelImpl = DataModelImpl()
    let api:MovieApi = MovieApiClient.shared
    let db :Dao = RealmHelper.shared
    
    private init(){}
    
//
//    func getAllNowShowingMovies() -> Observable<[MovieVO]> {
//
//        db.getNowShowingMovies()
//
//    }

    func getMoviesFromAPI(status: String) {
        _ = api.getMovies(status: status)
            .flatMap{self.db.saveAllMovies(data: $0.results, status: status)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getAllMovies(status: MovieStatus) -> Observable<[MovieVO]> {
        //db.getUpcomingMovies()
        db.getMoviesByStatus(status: status)
    }
    
    //========================= HOME =========================//
    
    func getTrendingMoviesFromAPI(page: Int) {
        _ = api.getTrendingMovies(page: page)
            .flatMap{self.db.saveTrendingMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getNowPlayingMoviesFromAPI(page: Int) {
        _ = api.getNowPlayingMovies(page: page)
            .flatMap{self.db.saveNowPlayingMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getUpcomingMoviesFromAPI(page: Int) {
        _ = api.getUpcomingMovies(page: page)
            .flatMap{self.db.saveUpcomingMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getTopRatedMoviesFromAPI(page: Int) {
        _ = api.getTopRatedMovies(page: page)
            .flatMap{self.db.saveTopRatedMovies(data: $0.results)}
        .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getTrendingMovies() -> Observable<[TrendingMovieVO]> {
        db.getTrendingMovies()
    }
    
    func getNowPlayingMovies() -> Observable<[NowPlayingMovieVO]> {
        db.getNowShowingMovies()
    }
    
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]> {
        db.getUpcomingMovies()
    }
    
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]> {
        db.getTopRatedMovies()
    }
    
    //========================= DETAIL =========================//
    
    func getMovieByIdFromAPI(id: Int) {
        _ = api.getMovieById(id: id)
            .map{self.db.saveMovieDetail(data: $0)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getMovieById(id: Int) -> Observable<MovieDetailVO> {
        db.getMovieById(id: id)
    }
    
    func getMovieDetail(id: Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        return api.getMovieDetail(id: id, success: { (data) in
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getMovieVideo(id: Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void) {
        return api.getMovieVideo(id: id, success: { (data) in
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getSimilarMovie(id: Int) {
         _ = api.getSimilarMoviesById(id: id, page: 1)
                .flatMap{self.db.saveSimilarMovies(data: $0.results)}
                .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getSimilarMovieObservable() -> Observable<[SimilarMovieVO]> {
        db.getSimilarMovies()
    }
    
    func deleteSimilarMovie() {
        db.deleteOldSimilarMovies()
    }
    
    func addMovieToRatedList(id: Int, sessionId: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.addMovieToRated(id: id, sessionId: sessionId, success: { (data) in
            if data.statusCode == 12 {
                success(data.statusMessage)
            }
            fail(data.statusMessage)
            
        }) { (error) in
            fail(error)
        }
    }
    
    func addMovieToWatchedList(userId: Int, movieId: Int, sessionId: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        api.addMovieToWatched(userId: userId, movieId: movieId, sessionId: sessionId, success: { (data) in
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
        api.searchMovies(movieName: movieName)
            .map{ movieResponse in movieResponse.results}
            .catchError { (error) -> Observable<[SearchMovieVO]> in
                debugPrint(error.localizedDescription)
                return Observable.just([SearchMovieVO]())
            }
    }
    
    //========================= LOGIN =========================//
    func requestToken(success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        api.requestToken(success: { (data) in
            
            UserDefaultUtil.shared.saveToken(token: data.requestToken)
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    func loginWithToken(username: String, password: String, token : String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        
        api.loginWithToken(id: username, password: password ,token: token, success: { (data) in
            
            UserDefaultUtil.shared.saveUserName(userName: username)
            UserDefaultUtil.shared.savePassword(userName: password)
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        api.getSessionID(token: token, success: { (sessionID) in
            UserDefaultUtil.shared.saveSessionID(token: sessionID)
            success(sessionID)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    //========================= Profile =========================//
    func getAccoundtDetail(success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void) {
        api.getAccount(sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (data) in
            UserDefaultUtil.shared.saveUserId(userId: data.id)
            UserDefaultUtil.shared.saveUserName(userName: data.username)
            success(data)
            
        }) { (error) in
            debugPrint(error)
            fail(error)
        }
    }
    
    //func getAccountDetail() {
        
//        _ = api.getProfileDetail(sessionId: UserDefaultUtil.shared.retrieveSessionID())
//            .map{self.db.saveAccountDetail(data: $0)}
//            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
        
   // }
    func getRatedMovies() {
        _ = api.getRateMovies(sessionId: UserDefaultUtil.shared.retrieveSessionID(), accountId: UserDefaultUtil.shared.retrieveUserName())
            .flatMap{self.db.saveRatedMovies(data: $0.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    func getWatchMovies() {
        _ = api.getWatchMovies(sessionId: UserDefaultUtil.shared.retrieveSessionID(), accountId: UserDefaultUtil.shared.retrieveUserName())
            .flatMap{self.db.saveWatchedMovies(data: $0.results)}
            .subscribeOn(ConcurrentDispatchQueueScheduler.init(qos: .background)).subscribe()
    }
    
    func getAccountDetailObservable() -> Observable<AccountDetailResponse> {
        db.getAccountDetail()
    }
    func getRatedMoviesObservable() -> Observable<[RateMovieVO]> {
        db.getRatedMovie()
    }
    func getWatchMoviesObservable() -> Observable<[WatchMovieVO]> {
        db.getWatchedMovie()
    }
}
