//
//  MovieDetailResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 29/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
class MovieDetailResponse: Codable {
    let adult: Bool = false
    let backdropPath: String = ""
    let belongsToCollection: String? = ""
    let budget: Int = 0
    let genres = [Genre]()
    let homepage: String = ""
    let id: Int = 0
    let imdbID : String = ""
    let originalLanguage : String = ""
    let originalTitle : String = ""
    let overview: String = ""
    let popularity: Double = 0.0
    let posterPath: String = ""
    let productionCompanies = [ProductionCompany]()
    let productionCountries = [ProductionCountry]()
    let releaseDate: String = ""
    let revenue : Int = 0
    let runtime: Int = 0
    let spokenLanguages = [SpokenLanguage]()
    let status : String = ""
    let tagline : String = ""
    let title: String = ""
    let video: Bool = false
    let voteAverage: Double = 0.0
    let voteCount: Int = 0

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

}

// MARK: - Genre
class Genre: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - ProductionCompany
class ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }

    init(id: Int, logoPath: String?, name: String, originCountry: String) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

// MARK: - ProductionCountry
class ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    init(iso3166_1: String, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}

// MARK: - SpokenLanguage
class SpokenLanguage: Codable {
    let iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }

    init(iso639_1: String, name: String) {
        self.iso639_1 = iso639_1
        self.name = name
    }
}
