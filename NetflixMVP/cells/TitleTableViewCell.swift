//
//  TitleTableViewCell.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 16/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewHeaderFooterView {
    
    static var identifier : String {
        return "TitleTableViewCell"
    }

    @IBOutlet weak var labelTitle: UILabel!
    
}
