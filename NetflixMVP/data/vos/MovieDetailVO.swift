//
//  MovieDetailVO.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 29/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift

class MovieDetailVO: Object, Codable {
    @objc dynamic var adult: Bool = false
    @objc dynamic var backdropPath: String? = ""
    @objc dynamic var belongsToCollection : CollectionVO? = CollectionVO()
    @objc dynamic var budget: Int = 0
    var genres = List<GenreVO>()
    @objc dynamic var homepage: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var imdbID : String = ""
    @objc dynamic var originalLanguage : String = ""
    @objc dynamic var originalTitle : String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var popularity: Double = 0.0
    @objc dynamic var posterPath: String = ""
    var productionCompanies = List<ProductionCompanyVO>()
    var productionCountries = List<ProductionCountryVO>()
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var revenue : Int = 0
    @objc dynamic var runtime: Int = 0
    var spokenLanguages = List<SpokenLanguageVO>()
    @objc dynamic var status : String = ""
    @objc dynamic var tagline : String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var video: Bool = false
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// MARK: - Belongs TO Collection
class CollectionVO: Object,Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var posterPath: String? = ""
    @objc dynamic var backdropPath: String? = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case name
    }
}

// MARK: - Genre
class GenreVO: Object,Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// MARK: - ProductionCompany
class ProductionCompanyVO: Object,Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var logoPath: String? = ""
    @objc dynamic var name : String = ""
    @objc dynamic var originCountry: String = ""

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// MARK: - ProductionCountry
class ProductionCountryVO: Object,Codable {
    @objc dynamic var iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
    
    override static func primaryKey() -> String? {
        return "iso3166_1"
    }
}

// MARK: - SpokenLanguage
class SpokenLanguageVO: Object, Codable {
    @objc dynamic var iso639_1 : String = ""
    @objc dynamic var name: String = ""

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
    
    override static func primaryKey() -> String? {
        return "iso639_1"
    }
    
}
