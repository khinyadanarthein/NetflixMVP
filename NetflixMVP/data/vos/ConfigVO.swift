//
//  ConfigVO.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
struct ConfigVO:Codable {
    
    var apiurl:String
    var appId:String
    var secretKey:String
    
    enum CodingKeys:String,CodingKey {
        case apiurl = "api_url"
        case secretKey = "secret_key"
        case appId = "app_id"
        
    }
}
