//
//  MockRealmHelper.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 29/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
import Foundation
@testable import RealmSwift
@testable import RxRealm
@testable import RxSwift
@testable import NetflixMVP

class MockRealmHelper: XCTestCase {
     
    static let shared:MockRealmHelper = MockRealmHelper()
    
    let realm = try! Realm()
    
    //override private init(){}
  
}

extension MockRealmHelper : Dao {
    
    func saveTrendingMovies(data: [TrendingMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveNowPlayingMovies(data: [NowPlayingMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveUpcomingMovies(data: [UpcomingMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveTopRatedMovies(data: [TopRatedMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getNowShowingMovies() -> Observable<[NowPlayingMovieVO]> {
        //let movies = realm.objects(NowPlayingMovieVO.self)
        //return Observable.array(from: movies)
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "now_playing_list_result")
                XCTAssertNotNil(response)
                
                let data:GetNowPlayMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "upcoming_list_result")
                XCTAssertNotNil(response)
                
                let data:GetUpcomingMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getTrendingMovies() -> Observable<[TrendingMovieVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "trending_list_result")
                XCTAssertNotNil(response)
                
                let data:GetTrendingMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "top_rated_list_result")
                XCTAssertNotNil(response)
                
                let data:GetTopRatedMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func saveMovieDetail(data: MovieDetailVO) -> Observable<Bool> {
        
        XCTAssertNotNil(data)
        XCTAssertEqual(data.id, 547017)
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    XCTAssertTrue(true)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveSimilarMovies(data: [SimilarMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 20)
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    XCTAssertTrue(true)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getSimilarMovies() -> Observable<[SimilarMovieVO]> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "similar_movies_result")
                XCTAssertNotNil(response)
                
                let data:SimilarMoviesResponse? =  response.seralizeData()
                if let data = data {
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func deleteOldSimilarMovies() {
        do{
            try self.realm.write {
                realm.delete(realm.objects(SimilarMovieVO.self))
                let movies = realm.objects(SimilarMovieVO.self)
                XCTAssertNil(movies)
            }
        }catch let ex{
            debugPrint(ex.localizedDescription)
        }
        
    }
    
    func saveAccountDetail(data: AccountDetailResponse) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.id, 9282485)
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    XCTAssertTrue(true)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveRatedMovies(data: [RateMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 6)
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    XCTAssertTrue(true)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func saveWatchedMovies(data: [WatchMovieVO]) -> Observable<Bool> {
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 8)
        return Observable<Bool>.create({ observer -> Disposable in
            
            do{
                try self.realm.write {
                    self.realm.add(data,update: .modified)
                    XCTAssertTrue(true)
                    observer.onNext(true)
                    observer.onCompleted()
                }

            }catch let ex{
                debugPrint(ex.localizedDescription)
                observer.onError(NSError(domain: ex.localizedDescription, code: 500, userInfo: nil))
            }
            return Disposables.create {
                
            }
        })
    }
    
    func getAccountDetail() -> Observable<AccountDetailResponse> {
        
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "account_detail_result")
                XCTAssertNotNil(response)
                
                let data:AccountDetailResponse? =  response.seralizeData()
                if let data = data {
                    XCTAssertEqual(data.id, 9282485)
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getRatedMovie() -> Observable<[RateMovieVO]> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "user_rated_list_result")
                XCTAssertNotNil(response)
                
                let data:RateMoviesResponse? =  response.seralizeData()
                if let data = data {
                    XCTAssertEqual(data.results.count, 6)
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    func getWatchedMovie() -> Observable<[WatchMovieVO]> {
        return Observable.create { (observer) -> Disposable in
            do {
                let response = try Data.fromJSON(fileName: "user_watched_list_result")
                XCTAssertNotNil(response)
                
                let data:WatchMoviesResponse? =  response.seralizeData()
                if let data = data {
                    XCTAssertEqual(data.results.count, 8)
                    observer.onNext(data.results)
                    observer.onCompleted()
                }
            }catch let ex {
                debugPrint(ex.localizedDescription)
                XCTAssertNotNil(ex)
                observer.onError(ex)
            }
            return Disposables.create()
        }
    }
    
    
}
