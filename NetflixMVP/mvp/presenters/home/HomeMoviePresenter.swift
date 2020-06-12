//
//  HomeMoviePresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
protocol HomeMoviePresenter : MovieDelegate {
    
    var upComingMovie:[UpcomingMovieVO]  {get set}
    var trendingMovie:[TrendingMovieVO]  {get set}
    var nowPlayingMovie:[NowPlayingMovieVO]  {get set}
    var topRatedMovie:[TopRatedMovieVO] {get set}
    func onUIReady()
    func attachView(view:MovieListView)
    func deattachView()
    
}
