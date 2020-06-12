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
    }
    
    func attachView(view: MovieSearchView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    
}
