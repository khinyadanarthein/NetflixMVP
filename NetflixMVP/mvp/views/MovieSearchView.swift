//
//  MovieSearchView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol MovieSearchView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(err:String)
    func showMovieList(data: [SearchMovieVO])
}
