//
//  SearchMovieResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class SearchMovieResponse: Codable {
    let results : [SearchMovieVO]
    
    enum CodingKeys : String, CodingKey{
        case results = "results"
    }
}
