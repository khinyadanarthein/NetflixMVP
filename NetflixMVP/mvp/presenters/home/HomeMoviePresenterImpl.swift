//
//  HomeMoviePresenterImpl.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 19/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import Foundation
import RxSwift
class HomeMoviePresenterImpl {
    
    let bag:DisposeBag = DisposeBag()
    var upComingMovie: [UpcomingMovieVO] = []
    var trendingMovie: [TrendingMovieVO] = []
    var nowPlayingMovie : [NowPlayingMovieVO] = []
    var topRatedMovie : [TopRatedMovieVO] = []
    
    var mView: MovieListView? = nil
    let model : DataModel = DataModelImpl.shared
}

extension HomeMoviePresenterImpl : HomeMoviePresenter {
    
    func attachView(view: MovieListView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func onUIReady() {
        mView?.showLoading()
        //model.getUpcomingMovies()
        //model.getMoviesFromAPI(status: MovieStatus.upcoming.rawValue)
        
        model.getUpcomingMoviesFromAPI(page: 1)
        model.getUpcomingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.upComingMovie = data
                print("upcome list \(data.count)")
                self.mView?.showUpcomingMovies(data: self.upComingMovie)
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
        model.getTrendingMoviesFromAPI(page: 1)
        model.getTrendingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.trendingMovie = data
                print("trend list \(data.count)")
                self.mView?.showTrendingMovies(data: self.trendingMovie)
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
        model.getNowPlayingMoviesFromAPI(page: 1)
        model.getNowPlayingMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.nowPlayingMovie = data
                print("now play list \(data.count)")
                self.mView?.showNowPlayingMovies(data: self.nowPlayingMovie)
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
        model.getTopRatedMoviesFromAPI(page: 1)
        model.getTopRatedMovies()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.topRatedMovie = data
                print("top rated list \(data.count)")
                self.mView?.showTopRatedMovies(data: self.topRatedMovie)
            },onError:{ error in
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
        
    }
    
    func onTapMovie(id: Int) {
//        ApiClient.shared.getAllWonderList(success: { (data) in
//
//            print(data.wonders.count)
//
//            self.wonderList = data.wonders
//            self.tableViewWonder.reloadData()
//
//        }) { (error) in
//            
//            print(error)
//        }
        model.getMovieDetail(id: id, success: { (data) in
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
