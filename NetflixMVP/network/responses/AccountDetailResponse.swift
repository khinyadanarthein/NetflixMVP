//
//  AccountDetailResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 07/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
// MARK: - AccountDetailResponse
class AccountDetailResponse: Object, Codable {
    @objc dynamic var avatar : Avatar?
    @objc dynamic var id: Int = 0
    @objc dynamic var iso639_1: String = ""
    @objc dynamic var iso3166_1: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var includeAdult: Bool = false
    @objc dynamic var username: String = ""

    enum CodingKeys: String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

// MARK: - Avatar
class Avatar: Object, Codable {
    @objc dynamic var gravatar : Gravatar?
}

// MARK: - Gravatar
class Gravatar: Object, Codable {
    @objc dynamic var hashId: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case hashId = "hash"
    }
    override static func primaryKey() -> String? {
        return "hashId"
    }
    
}
