//
//  ProfilePresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 07/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol ProfilePresenter {
    
    var watchedMovieList : [WatchMovieVO] {get set}
    var ratedMovieList : [RateMovieVO] {get set}
    var accountInfo : AccountDetailResponse {get set}
    func onUIReady()
    func attachView(view:ProfileView)
    func deattachView()
    
}
