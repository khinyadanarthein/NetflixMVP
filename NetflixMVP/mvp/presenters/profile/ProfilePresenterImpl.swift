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
        
        model.getAccoundtDetail(success: { (data) in
            self.mView?.hideLoading()
            self.accountInfo = data
            self.mView?.showAccountDetail(data: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(err: error)
        }
        
        model.getRatedMovies()
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
        
        model.getWatchMovies()
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
    
}
