//
//  LoginPresenterImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 05/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class LoginPresenterImpl : LoginPresenter {
    var token: String = ""
    
    var userName: String = ""
    
    var password: String = ""
    
    var mView : LoginView?
    let model : DataModel = DataModelImpl.shared
    
    func onUIReady() {
        mView?.showLoading()
        userName = UserDefaultUtil.shared.retrieveUserName()
        password = UserDefaultUtil.shared.retrievePassword()
        
        model.requestToken(success: { (requestToken) in
            self.mView?.hideLoading()
            self.token = requestToken.requestToken
            UserDefaultUtil.shared.saveToken(token: requestToken.requestToken)
            UserDefaultUtil.shared.saveToken(token: requestToken.expiresAt)

            if UserDefaultUtil.shared.retrieveIsLogin() {
                self.login(userName: self.userName, password: self.password)
            }
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: "Request Token : " + error)
        }
        
    }
    
    func attachView(view: LoginView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func login(userName: String, password: String) {
        model.loginWithToken(username: userName, password: password, token: self.token, success: { (data) in
            self.model.getSessionID(token: self.token, success: { (dataStr) in
                self.mView?.hideLoading()
                UserDefaultUtil.shared.saveIsLogin(isLogin: true)
                self.mView?.navigateToProfileDetail()
                
            }) { (error) in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: "Login Session : " + error)
            }
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: "Login : " + error)
        }
    }
}
