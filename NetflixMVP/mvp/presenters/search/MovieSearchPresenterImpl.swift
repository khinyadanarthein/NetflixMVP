//
//  MovieSearchPresenterImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift

class MovieSearchPresenterImpl : MovieSearchPresenter {
    var movieList = [SearchMovieVO]()
    
    var mView : MovieSearchView?
    let bag:DisposeBag = DisposeBag()
    let model : DataModel = DataModelImpl.shared
    
    func onUIReady(movieName : String) {
        
        mView?.showLoading()
        model.searchMovie(movieName: movieName)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.movieList = data
                print("search list \(data.count)")
                self.mView?.showMovieList(data: data)
                
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
       // mView?.hideLoading()
    }
    
    func attachView(view: MovieSearchView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func onTapMovie(data: SearchMovieVO) {
        model.getMovieDetail(id: data.id!, success: { (data) in
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
