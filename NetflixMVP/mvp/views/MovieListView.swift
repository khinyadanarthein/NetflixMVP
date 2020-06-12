//
//  MovieListView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol MovieListView{
    func showUpcomingMovies(data:[UpcomingMovieVO])
    func showTrendingMovies(data:[TrendingMovieVO])
    func showNowPlayingMovies(data:[NowPlayingMovieVO])
    func showTopRatedMovies(data:[TopRatedMovieVO])
    func showLoading()
    func hideLoading()
    func showErrorMessage(err:String)
    func navigateToMovieDetail(movie : MovieDetailVO)
}
