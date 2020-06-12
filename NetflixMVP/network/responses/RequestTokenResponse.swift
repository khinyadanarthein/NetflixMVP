//
//  RequestTokenResponse.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 04/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
class RequestTokenResponse: Codable {
    let success: Bool
    let expiresAt, requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
