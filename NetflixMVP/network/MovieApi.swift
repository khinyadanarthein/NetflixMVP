//
//  MovieApi.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
protocol MovieApi {
    func getMovies(status : String) -> Observable<GetAllMoviesResponse>
    
    // Movie List
    func getTrendingMovies(page : Int) -> Observable<GetTrendingMoviesResponse>
    func getNowPlayingMovies(page : Int) -> Observable<GetNowPlayMoviesResponse>
    func getUpcomingMovies(page : Int) -> Observable<GetUpcomingMoviesResponse>
    func getTopRatedMovies(page : Int) -> Observable<GetTopRatedMoviesResponse>
    
    // Detail
    func getMovieById(id : Int) -> Observable<MovieDetailVO>
    func getMovieDetail(id : Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void)
    func getMovieVideo(id : Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void)
    func addMovieToRated(id : Int, sessionId : String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void)
    func addMovieToWatched(userId : Int, movieId : Int, sessionId : String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void)
    
    // Similar List
    func getSimilarMoviesById(id : Int, page : Int) -> Observable<SimilarMoviesResponse>
    
    // Search
    func searchMovies(movieName: String) -> Observable<SearchMovieResponse>
    
    // Login
    func requestToken(success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void)
    
    func loginWithToken(id : String, password : String, token : String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void)
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void)
    
    // Profile
    func getAccount(sessionId: String, success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void)
    func getProfileDetail(sessionId : String) -> Observable<AccountDetailResponse>
    func getRateMovies(sessionId : String, accountId: String) -> Observable<RateMoviesResponse>
    func getWatchMovies(sessionId : String, accountId: String) -> Observable<WatchMoviesResponse>
}
