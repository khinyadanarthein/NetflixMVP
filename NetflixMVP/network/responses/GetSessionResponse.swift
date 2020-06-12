//
//  GetSessionResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 04/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
class GetSessionResponse: Codable {
    let success: Bool
    let sessionId: String

    enum CodingKeys: String, CodingKey {
        case success
        case sessionId = "session_id"
    }
}
