//
//  MockDetailPresenterImpl.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
@testable import NetflixMVP
@testable import RxSwift

class MockDetailPresenterImpl: XCTestCase {
    
    var movieDetail = MovieDetailVO()
    var similarMovies = [SimilarMovieVO]()
    
    let bag:DisposeBag = DisposeBag()
    var mView: MovieDetailView? = nil
    let mockModel : DataModel = MockDataModelImpl.shared

}

extension MockDetailPresenterImpl : MovieDetailPresenter {
    func onUIReady(movieId: Int) {
        mView?.showLoading()
        mockModel.getSimilarMovie(id: movieId)
        mockModel.getSimilarMovieObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.similarMovies = data
                XCTAssertEqual(data.count, 20)
                self.mView?.showSimilarMovieList(movies: data)
                
            },onError:{ error in
                self.mView?.hideLoading()
                XCTAssertNotNil(error)
                self.mView?.showErrorMessage(title: "Loding Error",err: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func getMovieVideo(movieId: Int) {
        mView?.showLoading()
        mockModel.getMovieVideo(id: movieId, success: { (data) in
            self.mView?.hideLoading()
            XCTAssertEqual(data.size, 1080)
            self.mView?.loadMovieVideo(data: data)
            
        }) { (error) in
            self.mView?.hideLoading()
            XCTAssertNotNil(error)
            self.mView?.showErrorMessage(title: "Loading", err: "Video can't load now.")
        }
    }
    
    func rateMovie(movieId : Int) {
        mView?.showLoading()
        mockModel.addMovieToRatedList(id: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
            self.mView?.hideLoading()
            XCTAssertEqual(message, "The item/record was updated successfully.")
            self.mView?.ratedMovie(message: message)
            
        }) { (error) in
            self.mView?.hideLoading()
            XCTAssertNotNil(error)
            self.mView?.showErrorMessage(title: "Rating", err: error)
        }
    }
    
    func addWatchMovie(movieId :Int) {
        mView?.showLoading()
        mockModel.addMovieToWatchedList(userId: UserDefaultUtil.shared.retrieveUserId(), movieId: movieId, sessionId: UserDefaultUtil.shared.retrieveSessionID(), success: { (message) in
            self.mView?.hideLoading()
            XCTAssertEqual(message, "The item/record was updated successfully.")
            self.mView?.addWatchedMovie(message: "Add Watch List")
            
        }) { (error) in
            self.mView?.hideLoading()
            XCTAssertNotNil(error)
            self.mView?.showErrorMessage(title: "Add Watch",err: error)
        }
    }
    
    func attachView(view: MovieDetailView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
        mockModel.deleteSimilarMovie()
    }
    
}
