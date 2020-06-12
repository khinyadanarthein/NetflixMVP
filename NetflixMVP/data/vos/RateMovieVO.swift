//
//  RateMovieVO.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 07/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

// MARK: - Result
class RateMovieVO: Object, Codable {
    @objc dynamic var id:Int = 0
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var video: Bool = false
    @objc dynamic var posterPath : String = ""
    @objc dynamic var adult:Bool = false
    @objc dynamic var backdropPath:String? = ""
    @objc dynamic var originalLanguage:String = ""
    @objc dynamic var originalTitle:String = ""
    var genreIDS = List<Int>()
    @objc dynamic var title:String = ""
    @objc dynamic var voteAverage:Double = 0.0
    @objc dynamic var overview:String = ""
    @objc dynamic var releaseDate:String = ""
    @objc dynamic var rating: Double = 0.0

    enum CodingKeys: String, CodingKey {
        case id, video
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case title
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case posterPath = "poster_path"
        case popularity, rating
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
