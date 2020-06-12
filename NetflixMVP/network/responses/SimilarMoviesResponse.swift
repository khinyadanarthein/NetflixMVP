//
//  SimilarMoviesResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 02/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - SimilarMovieResponse
class SimilarMoviesResponse: Codable {
    let page: Int
    let results: [SimilarMovieVO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    init(page: Int, results: [SimilarMovieVO], totalPages: Int, totalResults: Int) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

// MARK: - Result
class SimilarMovieVO: Object, Codable {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String? = ""
    var genreIDS = List<Int>()
    @objc dynamic var id: Int = 0
    @objc dynamic var originalLanguage: String = ""
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var overview : String = ""
    @objc dynamic var posterPath : String? = ""
    @objc dynamic var releaseDate: String = ""
    let title: String = ""
    let video: Bool = false
    let voteAverage: Double = 0.0
    let voteCount: Int = 0
    let popularity: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case popularity
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
}
