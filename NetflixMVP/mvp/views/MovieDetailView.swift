//
//  MovieDetailView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 29/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol MovieDetailView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(title:String, err:String)
    func showMovieDetail(data: MovieDetailVO)
    func showSimilarMovieList(movies : [SimilarMovieVO])
    func ratedMovie(message : String)
    func addWatchedMovie(message : String)
    func loadMovieVideo(data : MovieVideoVO)
}
