//
//  RealmHelper.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

class RealmHelper: Dao {
     
    static let shared:RealmHelper = RealmHelper()
    
    let realm = try! Realm()
    
    private init(){}
    
    func getMovieById(id: Int) -> Observable<MovieDetailVO> {

        let movie = self.realm.objects(MovieDetailVO.self).filter("id = %@",id).first ?? MovieDetailVO()
        return Observable.from(object: movie)
    }
    
    
    func getMovieDetailById(id: Int) -> MovieDetailVO? {

        let movie = self.realm.objects(MovieDetailVO.self).filter("id = %@",id).first!
        return movie
    }
    
    func saveAllMovies(data: [MovieVO], status: String) -> Observable<Bool> {
        
        var allMovieList = [AllMovieVO]()
        do{

            try self.realm.write {
                let allMovieVO = AllMovieVO()
                for movie in data {
                    allMovieVO.movieInfo = movie
                    allMovieVO.id = movie.id
                    allMovieVO.status = status
                    allMovieList.append(allMovieVO)
                }
                
            }

        }catch let ex{
            debugPrint(ex.localizedDescription)
            
        }
    
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
    
    func saveTrendingMovies(data: [TrendingMovieVO]) -> Observable<Bool> {
        
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
    
    func getNowShowingMovies() -> Observable<[MovieVO]> {
        
        let movies = realm.objects(MovieVO.self).filter("status = 'now'")
        return Observable.array(from: movies)
    }
    
    func getUpcomingMovies() -> Observable<[MovieVO]> {
        
        //let movies = realm.objects(MovieVO.self).filter("status = 'coming'")
        let movies = realm.objects(MovieVO.self)
        return Observable.array(from: movies)
    }
    
    func getMoviesByStatus(status: MovieStatus) -> Observable<[MovieVO]> {
        let movies = realm.objects(MovieVO.self)
        return Observable.array(from: movies)
    }
    
    func getNowShowingMovies() -> Observable<[NowPlayingMovieVO]> {
        let movies = realm.objects(NowPlayingMovieVO.self)
        return Observable.array(from: movies)
    }
    
    func getUpcomingMovies() -> Observable<[UpcomingMovieVO]> {
        let movies = realm.objects(UpcomingMovieVO.self)
        return Observable.array(from: movies)
    }
    
    func getTrendingMovies() -> Observable<[TrendingMovieVO]> {
        let movies = realm.objects(TrendingMovieVO.self)
        return Observable.array(from: movies)
    }
    
    func getTopRatedMovies() -> Observable<[TopRatedMovieVO]> {
        let movies = realm.objects(TopRatedMovieVO.self)
        return Observable.array(from: movies)
    }
    
    func saveMovieDetail(data: MovieDetailVO) -> Observable<Bool> {
        
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
    
    func saveSimilarMovies(data: [SimilarMovieVO]) -> Observable<Bool> {
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
    
    func getSimilarMovies() -> Observable<[SimilarMovieVO]> {
        let movies = realm.objects(SimilarMovieVO.self)
        return Observable.array(from: movies)
    }
    
    func deleteOldSimilarMovies() {
        do{
        try self.realm.write {
            realm.delete(realm.objects(SimilarMovieVO.self))
            }
        }catch let ex{
            debugPrint(ex.localizedDescription)
        }
        
    }
    
    //Profile
    func saveAccountDetail(data: AccountDetailResponse) -> Observable<Bool> {
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
     
     func saveRatedMovies(data: [RateMovieVO]) -> Observable<Bool> {
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
     
     func saveWatchedMovies(data: [WatchMovieVO]) -> Observable<Bool> {
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
    
    func getAccountDetail() -> Observable<AccountDetailResponse> {
        let account = realm.objects(AccountDetailResponse.self).first!
        return Observable.from(object: account)
    
    }
    func getRatedMovie() -> Observable<[RateMovieVO]> {
        let movies = realm.objects(RateMovieVO.self)
        return Observable.array(from: movies)
    
    }
    func getWatchedMovie() -> Observable<[WatchMovieVO]> {
        let movies = realm.objects(WatchMovieVO.self)
        return Observable.array(from: movies)
    
    }
}
