//
//  SearchMovieVO.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class SearchMovieVO: Codable {
    let title : String?
    let posterPath : String?
    let overview : String?
    
    enum CodingKeys : String, CodingKey{
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
    }
}
