//
//  MockDataImpl.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 14/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import UIKit
@testable import NetflixMVP

class MockSearchPresenterImpl : MovieSearchPresenter {
    
    var movieList: [SearchMovieVO] = []
    
    func onUIReady(movieName: String) {
        
    }
    
    func attachView(view: MovieSearchView) {
        
    }
    
    func deattachView() {
        
    }
    
    func onTapMovie(data: SearchMovieVO) {
        
    }
}
