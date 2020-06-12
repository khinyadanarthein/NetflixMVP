//
//  MovieDetailPresenterImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 30/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class MovieDetailPresenterImpl {
    
    
    var movieDetail = MovieDetailVO()
    var similarMovies = [SimilarMovieVO]()
    
    let bag:DisposeBag = DisposeBag()
    var mView: MovieDetailView? = nil
    let model : DataModel = DataModelImpl.shared
}

extension MovieDetailPresenterImpl : MovieDetailPresenter {
    func onUIReady(movieId : Int) {
        mView?.showLoading()
        model.getSimilarMovie(id: movieId)
        //let movie = model.getMovieById(id: movieId)
        //mView?.showMovieDetail(data: model.getMovieById(id: movieId)!)
        model.getSimilarMovieObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.similarMovies = data
                print("similar list \(data.count)")
                self.mView?.showSimilarMovieList(movies: data)
                
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(title: "Loding Error",err: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func getMovieVideo(movieId: Int) {
        mView?.showLoading()
        model.getMovieVideo(id: movieId, success: { (data) in
            self.mView?.hideLoading()
            self.mView?.loadMovieVideo(data: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(title: "Loading", err: "Video can't load now.")
        }
    }
    
    func rateMovie(movieId : Int) {
        mView?.showLoading()
        model.addMovieToRatedList(id: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
            self.mView?.hideLoading()
            self.mView?.ratedMovie(message: message)
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(title: "Rating", err: error)
        }
    }
    
    func addWatchMovie(movieId :Int) {
        mView?.showLoading()
        model.addMovieToWatchedList(userId: UserDefaultUtil.shared.retrieveUserId(), movieId: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
            self.mView?.hideLoading()
            self.mView?.addWatchedMovie(message: "Add Watch List")
            
        }) { (error) in
            self.mView?.hideLoading()
            self.mView?.showErrorMessage(title: "Add Watch",err: error)
        }
    }
    
    func attachView(view: MovieDetailView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
        model.deleteSimilarMovie()
    }
    
    
}
