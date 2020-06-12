//
//  GetAllMovieResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
class GetAllMoviesResponse: Codable {
    
    var results:[MovieVO] = []
    var page: Int = 0
    var totalResults: Int = 0
    var dates: Dates
    var totalPages: Int = 0
    

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}
// MARK: - Dates
class Dates: Codable {
    let maximum, minimum: String

    init(maximum: String, minimum: String) {
        self.maximum = maximum
        self.minimum = minimum
    }
}

class GetUpcomingMoviesResponse: Codable {
    
    var results:[UpcomingMovieVO] = []
    var page: Int = 0
    var totalResults: Int = 0
    var dates: Dates
    var totalPages: Int = 0
    

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}


class GetTrendingMoviesResponse: Codable {
    
    var results:[TrendingMovieVO] = []
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}


class GetNowPlayMoviesResponse: Codable {
    
    var results:[NowPlayingMovieVO] = []
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

class GetTopRatedMoviesResponse: Codable {
    
    var results:[TopRatedMovieVO] = []
    var page: Int = 0
    var totalResults: Int = 0
    var totalPages: Int = 0
    

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
