//
//  MockDetailViewController.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import XCTest
@testable import RxSwift
@testable import NetflixMVP
@testable import YoutubePlayer_in_WKWebView

class MockDetailViewController: UIViewController {
    
    var id : Int!
    var movie : MovieDetailVO?
    
    var mPresenter : MovieDetailPresenter = MockDetailPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initIndicator()
        initDataObservationMVP()
        //registerView()
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        XCTAssertNotNil(movie)
        XCTAssertEqual(self.movie!.id, 547016)
        mPresenter.onUIReady(movieId: self.movie!.id)
        //self.bindData(movie: self.movie!)
    }
    
}

extension MockDetailViewController : MovieDetailView {
    func showSimilarMovieList(movies: [SimilarMovieVO]) {
        self.mPresenter.similarMovies = movies
        XCTAssertNotNil(movies)
        XCTAssertEqual(movies.count, 20)
        //self.collectionViewSimilarMovie.reloadData()
    }
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(title : String , err: String) {
        debugPrint(err)
        let alert = UIAlertController(title: title, message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMovieDetail(data: MovieDetailVO) {
        self.mPresenter.movieDetail = data
        //bindData(movie: data)
    }
    
    func ratedMovie(message: String) {
        XCTAssertEqual(message, "The item/record was updated successfully.")
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    func addWatchedMovie(message: String) {
        XCTAssertEqual(message, "The item/record was updated successfully.")
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    func loadMovieVideo(data: MovieVideoVO) {
//        ytPlayerHeightConstant.constant = 150
//        print(data.key ?? "")
//        self.youtubelayerView.load(withVideoId: data.key ?? "")
        XCTAssertEqual(data.key, "aK-X2d0lJ_s")
    }
}
