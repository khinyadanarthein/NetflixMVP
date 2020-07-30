//
//  MockViewController.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import XCTest
@testable import RxSwift
@testable import NetflixMVP

class MockSearchViewController : UIViewController {
    
    var mPresenter : MovieSearchPresenter = MockSearchPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let disposebag : DisposeBag = DisposeBag()
    
    func test_initview () {
        initIndicator()
        initDataObservationMVP()
        initView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIndicator()
        initDataObservationMVP()
        initView()
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        mPresenter.onUIReady(movieName: "the")
    }
    
    private func initView() {
        
    }
}

extension MockSearchViewController: MovieSearchView {
    
    func showLoading() {
        self.activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        self.activityIndicator.stopAnimating()
    }
    
    func showErrorMessage(err: String) {
        debugPrint(err)
        let alert = UIAlertController(title: "Loading Error", message: err, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMovieList(data: [SearchMovieVO]) {
        self.mPresenter.movieList = data
        XCTAssertNotNil(data)
        XCTAssertEqual(data.count, 5)
        //self.collectionViewMovieResult.reloadData()
        self.mPresenter.onTapMovie(data: data[0])
    }
    
    func navigateToMovieDetail(movie: MovieDetailVO) {
        let vc = MockDetailViewController()
        //if let vc = vc {
            vc.movie = movie
            XCTAssertEqual(movie.id, 547016)
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        //}
    }
    
    
}

