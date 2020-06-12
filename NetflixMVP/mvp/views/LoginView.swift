//
//  LoginView.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 05/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol LoginView {
    
    func showLoading()
    func hideLoading()
    func showErrorMessage(err:String)
    func navigateToProfileDetail()
}
