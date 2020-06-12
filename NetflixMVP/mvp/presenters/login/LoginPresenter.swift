//
//  LoginPresenter.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 05/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

protocol LoginPresenter {
    
    var token : String {get set}
    var userName : String {get set}
    var password : String {get set}
    
    func onUIReady()
    func attachView(view:LoginView)
    func deattachView()
    func login(userName : String , password : String)
    
}
