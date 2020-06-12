//
//  ProfileView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 09/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol ProfileView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(err:String)
    func showAccountDetail(data:AccountDetailResponse)
    func showRatedMovies(data:[RateMovieVO])
    func showWatchedMovies(data:[WatchMovieVO])
}
