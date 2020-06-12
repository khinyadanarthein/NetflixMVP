//
//  RateMoviesResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 07/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
// MARK: - RateMoviesResponse
class RateMoviesResponse: Codable {
    let page: Int
    let results: [RateMovieVO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(page: Int, results: [RateMovieVO], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}
