//
//  ProfilePresenterImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 09/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class ProfilePresenterImpl : ProfilePresenter {
    var accountInfo = AccountDetailResponse()
    var ratedMovieList = [RateMovieVO]()
    var watchedMovieList = [WatchMovieVO]()
    
    var mView : ProfileView?
    let bag:DisposeBag = DisposeBag()
    let model : DataModel = DataModelImpl.shared
    
    func onUIReady() {
        mView?.showLoading()
//        model.getAccountDetail()
//        model.getAccountDetailObservable()
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext:{ data in
//                self.mView?.hideLoading()
//                self.accountInfo = data
//                self.mView?.showAccountDetail(data: data)
//                
//            },onError:{ error in
//                self.mView?.hideLoading()
//                self.mView?.showErrorMessage(err: error.localizedDescription)
//            }).disposed(by: bag)
        
        model.getAccoundtDetail(sessionId:UserDefaultUtil.shared.retrieveSessionID() ,success: { (data) in
            self.mView?.hideLoading()
            self.accountInfo = data
            self.mView?.showAccountDetail(data: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error)
        }
        
        model.getRatedMovies(sessionId:UserDefaultUtil.shared.retrieveSessionID(), accountId: UserDefaultUtil.shared.retrieveUserName())
        model.getRatedMoviesObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.ratedMovieList = data
                print("search list \(data.count)")
                self.mView?.showRatedMovies(data: data)
                
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
        model.getWatchMovies(sessionId:UserDefaultUtil.shared.retrieveSessionID(), accountId: UserDefaultUtil.shared.retrieveUserName())
        model.getWatchMoviesObservable()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext:{ data in
            self.mView?.hideLoading()
            self.watchedMovieList = data
            print("search list \(data.count)")
            self.mView?.showWatchedMovies(data: data)
            
        },onError:{ error in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error.localizedDescription)
        }).disposed(by: bag)
    }
    
    func attachView(view: ProfileView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func onTapMovie(movieId: Int) {
        model.getMovieDetail(id: movieId, success: { (data) in
            self.mView?.navigateToMovieDetail(movie: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            //self.mView?.showErrorMessage(err: error)
            
            let movieDetail = MovieDetailVO()
            movieDetail.id = UserDefaultUtil.shared.retrieveMovieId()
            movieDetail.posterPath = UserDefaultUtil.shared.retrieveMoviePoster()
            movieDetail.adult = UserDefaultUtil.shared.retrieveMovieIsAdult()
            movieDetail.backdropPath = UserDefaultUtil.shared.retrieveMoviePoster()
            movieDetail.releaseDate = UserDefaultUtil.shared.retrieveMovieDate()
            movieDetail.overview = UserDefaultUtil.shared.retrieveMovieOverview()
            self.mView?.navigateToMovieDetail(movie: movieDetail)
        }
    }
}
