//
//  Utils.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 09/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class Utils {
    
    static let shared : Utils = Utils()
    
    private init() {}
    
    func minutesToHoursMinutes (minutes : Int) -> (hours : Int , leftMinutes : Int) {
        return (minutes / 60, (minutes % 60))
    }
}
