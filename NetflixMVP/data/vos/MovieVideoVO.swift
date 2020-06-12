//
//  MovieVideoVO.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 11/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - MovieVideoVO

class MovieVideoVO: Codable {
    let id: String?
    let iso639_1: String?
    let iso3166_1: String?
    let key: String?
    let name: String?
    let site: String?
    let size: Int?
    let type: String?
    
    init(id: String, iso639_1: String, iso3166_1: String, key: String, name: String, site: String, size: Int, type: String) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}
