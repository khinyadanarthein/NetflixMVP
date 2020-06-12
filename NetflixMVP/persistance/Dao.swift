//
//  Dao.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

protocol Dao {
    func saveAllMovies(data:[MovieVO], status:String) -> Observable<Bool>
    func getMoviesByStatus(status : MovieStatus) -> Observable<[MovieVO]>
    
    func saveTrendingMovies(data:[TrendingMovieVO]) -> Observable<Bool>
    func saveNowPlayingMovies(data:[NowPlayingMovieVO]) -> Observable<Bool>
    func saveUpcomingMovies(data:[UpcomingMovieVO]) -> Observable<Bool>
    func saveTopRatedMovies(data:[TopRatedMovieVO]) -> Observable<Bool>
    
    func getNowShowingMovies() -> Observable<[NowPlayingMovieVO]>
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]>
    func getTrendingMovies() -> Observable<[TrendingMovieVO]>
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]>
    
    func saveMovieDetail(data : MovieDetailVO) -> Observable<Bool>
    func getMovieById(id:Int) -> Observable<MovieDetailVO>
    func getMovieDetailById(id: Int) -> MovieDetailVO?
    
    func saveSimilarMovies(data:[SimilarMovieVO]) -> Observable<Bool>
    func getSimilarMovies() -> Observable<[SimilarMovieVO]>
    func deleteOldSimilarMovies()
    
    func saveAccountDetail(data: AccountDetailResponse) -> Observable<Bool>
    func saveRatedMovies(data:[RateMovieVO]) -> Observable<Bool>
    func saveWatchedMovies(data:[WatchMovieVO]) -> Observable<Bool>
    
    func getAccountDetail() -> Observable<AccountDetailResponse>
    func getRatedMovie() -> Observable<[RateMovieVO]>
    func getWatchedMovie() -> Observable<[WatchMovieVO]>
}
