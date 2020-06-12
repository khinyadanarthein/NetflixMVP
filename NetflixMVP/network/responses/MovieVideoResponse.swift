//
//  MovieVideoResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 11/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

// MARK: - MovieVideoResponse
class MovieVideoResponse: Codable {
    let id: Int?
    let results : [MovieVideoVO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case results
    }

}
