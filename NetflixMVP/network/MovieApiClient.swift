//
//  MovieApiClient.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class MovieApiClient: BaseApiClient {
    
    static let shared:MovieApiClient = MovieApiClient()
    
    private override init() {}
}


extension MovieApiClient : MovieApi {
     
    func getMovies(status: String) -> Observable<GetAllMoviesResponse> {
        
        var url = API_GET_MOVIE
        switch status {
        case MovieStatus.trending.rawValue:
            url = url + API_GET_TRENDING_MOVIES
            
        case MovieStatus.nowshowing.rawValue:
            url = url + API_GET_NOW_PLAYING_MOVIES
            
        case MovieStatus.upcoming.rawValue:
            url = url + API_GET_UPCOMING_MOVIES
            
        case MovieStatus.toprated.rawValue:
            url = url + API_GET_TOP_RATED_MOVIES
            
        default:
            break
        }
            return  self.reuqestApiWithHeaders(url: url
            , method: .get
            , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE: 1]
            , value:GetAllMoviesResponse.self)
    }
    
    //========================= HOME =========================//
    
    func getTrendingMovies(page : Int) -> Observable<GetTrendingMoviesResponse> {
        let url = API_GET_MOVIE + API_GET_TRENDING_MOVIES
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE: page]
        , value:GetTrendingMoviesResponse.self )
    }
    
    func getNowPlayingMovies(page : Int) -> Observable<GetNowPlayMoviesResponse> {
        let url = API_GET_MOVIE + API_GET_NOW_PLAYING_MOVIES
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE: page]
        , value:GetNowPlayMoviesResponse.self )
    }
    
    func getTopRatedMovies(page : Int) -> Observable<GetTopRatedMoviesResponse> {
        let url = API_GET_MOVIE + API_GET_TOP_RATED_MOVIES
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE: page]
        , value:GetTopRatedMoviesResponse.self )
    }
    
    func getUpcomingMovies(page : Int) -> Observable<GetUpcomingMoviesResponse> {
        let url = API_GET_MOVIE + API_GET_UPCOMING_MOVIES
        return  self.reuqestApiWithHeaders(url: url
            , method: .get
            , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE: page]
            , value:GetUpcomingMoviesResponse.self )
    }
    
    //========================= DETAIL =========================//
    
    func getMovieById(id: Int) -> Observable<MovieDetailVO> {
        let url = API_GET_MOVIE + "\(id)"
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        , value:MovieDetailVO.self )
    }
    
    func getMovieDetail(id : Int, success: @escaping (MovieDetailVO) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_MOVIE + "\(id)"
        let params = [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(MovieDetailVO.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getMovieVideo(id : Int, success: @escaping (MovieVideoVO) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_MOVIE + "\(id)" + API_GET_MOVIE_VIDEO
        print("request url \(url)")
        let params = [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(MovieVideoResponse.self, from: response)
            
            success((data.results?.first!)!)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getSimilarMoviesById(id: Int, page: Int) -> Observable<SimilarMoviesResponse> {
        let url = API_GET_MOVIE + "\(id)" + API_GET_MOVIE_SIMILAR
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_LANG: PARAM_LANGUAGE, PARAM_PAGE : page]
        , value:SimilarMoviesResponse.self )
    }
    
    func addMovieToRated(id: Int, sessionId : String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        let url = API_GET_MOVIE + "\(id)" + API_ADD_RATED_LIST
        let params = [PARAM_API_KEY: API_KEY, PARAM_SESSION_ID: sessionId, PARAM_RATE_VALUE : "5.0"]
        
        self.requestApiWithoutObservable(url: url, method: .post, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(UpdateResponse.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func addMovieToWatched(userId: Int, movieId: Int, sessionId : String, success: @escaping (UpdateResponse) -> Void, fail: @escaping (String) -> Void) {
        let url = API_ACCOUNT + "\(userId)" + API_ADD_WATCHED_LIST
        let params = [
            PARAM_API_KEY: API_KEY
            , PARAM_SESSION_ID: sessionId
            , PARAM_MEDIA_TYPE : "movie"
            , PARAM_MEDIA_ID : "\(movieId)"
            , PARAM_WATCHLIST : "true"]
        
        self.requestApiWithoutObservable(url: url, method: .post, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(UpdateResponse.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    //========================= SEARCH =========================//
    
    func searchMovies(movieName: String) -> Observable<SearchMovieResponse> {
        
        let parameters : Parameters = [
            PARAM_API_KEY : API_KEY,
            PARAM_QUERY : movieName
        ]
        let url = API_SEARCH_MOVIE
        
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: parameters
        , value:SearchMovieResponse.self )
        
    }
    //========================= LOGIN =========================//
    
    func requestToken(success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        let url = API_REQUEST_TOKEN
        let params = [PARAM_API_KEY: API_KEY]
        
        self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(RequestTokenResponse.self, from: response)
            
            success(data)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    func loginWithToken(id: String, password: String, token: String, success: @escaping (RequestTokenResponse) -> Void, fail: @escaping (String) -> Void) {
        
        let url = API_LOGIN_WITH_TOKEN
        let params = [PARAM_API_KEY: API_KEY, PARAM_USERNAME:id,PARAM_PASSWORD:password,PARAM_TOKEN: token]
        
        self.requestApiWithoutObservable(url: url, method: .post, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            do{
                
                let data = try JSONDecoder().decode(RequestTokenResponse.self, from: response)
                success(data)
                
            } catch let ex {
                
                debugPrint(ex.localizedDescription)
                fail("Invalid username or password.")
            }
            
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    func getSessionID(token: String, success: @escaping (String) -> Void, fail: @escaping (String) -> Void) {
        
        let url = API_GET_SESSION
        let params = [PARAM_API_KEY: API_KEY, PARAM_TOKEN: token]
        
        self.requestApiWithoutObservable(url: url, method: .post, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
            
            let data = try! JSONDecoder().decode(GetSessionResponse.self, from: response)
            
            success(data.sessionId)
            
        }) { (error) in
            print(error)
            fail(error)
        }
    }
    
    //========================= PROFILE =========================//
    func getAccount(sessionId: String, success: @escaping (AccountDetailResponse) -> Void, fail: @escaping (String) -> Void) {
         let url = API_ACCOUNT_DETAIL
         let params = [PARAM_API_KEY: API_KEY, PARAM_SESSION_ID : sessionId]
         
         self.requestApiWithoutObservable(url: url, method: .get, params: params, encoding: URLEncoding(destination: .queryString), success: { (response) in
             
             let data = try! JSONDecoder().decode(AccountDetailResponse.self, from: response)
             
             success(data)
             
         }) { (error) in
             print(error)
             fail(error)
         }
     }
     
    
    func getProfileDetail(sessionId : String) -> Observable<AccountDetailResponse> {
        
        let url = API_ACCOUNT
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_SESSION_ID : sessionId]
        , value:AccountDetailResponse.self )
    }
    
    func getRateMovies(sessionId: String, accountId: String) -> Observable<RateMoviesResponse> {
        
        let url = API_ACCOUNT + accountId + API_ACCOUNT_RATE_LIST
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_SESSION_ID : sessionId]
        , value:RateMoviesResponse.self )
    }
    
    func getWatchMovies(sessionId: String, accountId: String) -> Observable<WatchMoviesResponse> {
        
        let url = API_ACCOUNT + accountId + API_ACCOUNT_WATCH_LIST
        return  self.reuqestApiWithHeaders(url: url
        , method: .get
        , params: [PARAM_API_KEY: API_KEY, PARAM_SESSION_ID : sessionId]
        , value:WatchMoviesResponse.self )
    }
}
