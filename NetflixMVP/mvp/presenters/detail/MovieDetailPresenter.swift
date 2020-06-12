//
//  MovieDetailPresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 30/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol MovieDetailPresenter {
    
    var movieDetail:MovieDetailVO {get set}
    var similarMovies : [SimilarMovieVO] {get set}
    func onUIReady(movieId : Int)
    func getMovieVideo(movieId : Int)
    func rateMovie(movieId : Int)
    func addWatchMovie(movieId : Int)
    func attachView(view:MovieDetailView)
    func deattachView()
    
}
