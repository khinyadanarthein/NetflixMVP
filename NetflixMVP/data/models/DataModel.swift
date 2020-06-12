//
//  DataModel.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol DataModel {
    
    func getMoviesFromAPI(status : String)
    func getAllMovies(status : MovieStatus) -> Observable<[MovieVO]>
    
    //Home
    func getTrendingMoviesFromAPI(page : Int)
    func getNowPlayingMoviesFromAPI(page : Int)
    func getUpcomingMoviesFromAPI(page : Int)
    func getTopRatedMoviesFromAPI(page : Int)
    func getTrendingMovies() -> Observable<[TrendingMovieVO]>
    func getNowPlayingMovies() -> Observable<[NowPlayingMovieVO]>
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]>
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]>
    
    // Detail
    func getMovieByIdFromAPI(id : Int)
    func getMovieById(id : Int) -> Observable<MovieDetailVO>
    func getMovieDetail(id : Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void)
    func getMovieVideo(id : Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void)
    func getSimilarMovie(id : Int)
    func getSimilarMovieObservable() -> Observable<[SimilarMovieVO]>
    func deleteSimilarMovie()
    func addMovieToRatedList(id : Int,sessionId : String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void)
    func addMovieToWatchedList(userId: Int, movieId : Int,sessionId : String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void)
    
    //Search
    func searchMovie(movieName: String) -> Observable<[SearchMovieVO]>
    
    //Login
    func requestToken(success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void)
    func loginWithToken(username : String, password : String, token : String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void)
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void)
    
    //Profile
    //func getAccountDetail()
    func getAccoundtDetail(success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void)
    func getAccountDetailObservable() -> Observable<AccountDetailResponse>
    func getRatedMovies()
    func getRatedMoviesObservable() -> Observable<[RateMovieVO]>
    func getWatchMovies()
    func getWatchMoviesObservable() -> Observable<[WatchMovieVO]>
    
}
