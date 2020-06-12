//
//  UserDefaultUtil.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 04/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation

class UserDefaultUtil {
    
    static let shared : UserDefaultUtil = UserDefaultUtil()
    
    private init() {}
    
    // LOGIN DATA
    func saveIsLogin(isLogin : Bool) {
        UserDefaults.standard.set(isLogin, forKey: USER_DEF_IS_LOGIN)
    }
    
    func retrieveIsLogin() -> Bool {
        UserDefaults.standard.bool(forKey: USER_DEF_IS_LOGIN)
    }
    
    func saveToken(token : String) {
        UserDefaults.standard.set(token, forKey: USER_DEF_TOKEN)
    }
    
    func retrieveToken() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_TOKEN) ?? ""
    }
    
    func saveExpireTime(token : String) {
        UserDefaults.standard.set(token, forKey: USER_DEF_EXPIRE_AT)
    }
    
    func retrieveExpireTime() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_EXPIRE_AT) ?? ""
    }
    
    func saveSessionID(token : String) {
        UserDefaults.standard.set(token, forKey: USER_DEF_SESSION_ID)
    }
    
    func retrieveSessionID() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_SESSION_ID) ?? ""
    }
    
    func saveUserId(userId : Int) {
        UserDefaults.standard.set(userId, forKey: USER_DEF_USERID)
    }
    
    func retrieveUserId() -> Int {
        UserDefaults.standard.integer(forKey: USER_DEF_USERID) 
    }
    
    func saveUserName(userName : String) {
        UserDefaults.standard.set(userName, forKey: USER_DEF_USERNAME)
    }
    
    func retrieveUserName() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_USERNAME) ?? ""
    }
    
    func savePassword(userName : String) {
        UserDefaults.standard.set(userName, forKey: USER_DEF_PASSWORD)
    }
    
    func retrievePassword() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_PASSWORD) ?? ""
    }
    
    // Movie Data
    func saveMovieId(movieId : Int) {
        UserDefaults.standard.set(movieId, forKey: USER_DEF_MOVIEID)
    }
    
    func retrieveMovieId() -> Int {
        UserDefaults.standard.integer(forKey: USER_DEF_MOVIEID)
    }
    
    func saveMovieOverview(overview : String) {
        UserDefaults.standard.set(overview, forKey: USER_DEF_OVERVIEW)
    }
    
    func retrieveMovieOverview() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_OVERVIEW) ?? ""
    }
    func saveMovieIsAdult(isAdult : Bool) {
        UserDefaults.standard.set(isAdult, forKey: USER_DEF_IS_ADULT)
    }
    
    func retrieveMovieIsAdult() -> Bool {
        UserDefaults.standard.bool(forKey: USER_DEF_IS_ADULT)
    }
    
    func saveMovieDate(date : String) {
        UserDefaults.standard.set(date, forKey: USER_DEF_RELEASE_DATE)
    }
    
    func retrieveMovieDate() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_RELEASE_DATE) ?? ""
    }
    
    func saveMoviePoster(path : String) {
        UserDefaults.standard.set(path, forKey: USER_DEF_POSTERPATH)
    }
    
    func retrieveMoviePoster() -> String {
        UserDefaults.standard.string(forKey: USER_DEF_POSTERPATH) ?? ""
    }
    
}
