//
//  MovieSearchPresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol MovieSearchPresenter {
    
    var movieList : [SearchMovieVO] {get set}
    func onUIReady(movieName : String)
    func attachView(view:MovieSearchView)
    func deattachView()
    
}
