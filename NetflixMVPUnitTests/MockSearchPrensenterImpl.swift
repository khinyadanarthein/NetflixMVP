//
//  MockDataImpl.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 14/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import NetflixMVP
@testable import RxSwift

class MockSearchPresenterImpl : XCTestCase {
    
    var movieList: [SearchMovieVO] = []
    
    var mView : MovieSearchView?
    let bag:DisposeBag = DisposeBag()
    let mockModel : DataModel = MockDataModelImpl.shared
}


extension MockSearchPresenterImpl : MovieSearchPresenter {
    
    func onUIReady(movieName: String) {
        
        mView?.showLoading()
        mockModel.searchMovie(movieName: movieName)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{ data in
                self.mView?.hideLoading()
                self.movieList = data
                XCTAssertEqual(data.count, 5)
                self.mView?.showMovieList(data: data)
                
            },onError:{ error in
                XCTAssertNotNil(error)
                self.mView?.hideLoading()
                self.mView?.showErrorMessage(err: error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func test_UIReady() {
        onUIReady(movieName: "the")
        let json = try! Data.fromJSON(fileName: "search_result")
        let data : SearchMovieResponse! = json.seralizeData()
        onTapMovie(data: data.results[0])
    }
    
    func attachView(view: MovieSearchView) {
        self.mView = view
    }
    
    func deattachView() {
        self.mView = nil
    }
    
    func onTapMovie(data: SearchMovieVO) {
        XCTAssertNotNil(data)
        mockModel.getMovieDetail(id: 547016, success: { (data) in
            
            XCTAssertEqual(data.budget, 70000000)
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
