//
//  MockViewController.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//




/**
 
 
 SearchViewController ကို Test လုပ်ချင်တယ်ဆိုရင် သက်ဆိုင် Object တွေကို Mock လုပ်ပေးရမယ်။
 For Example,
 
 class TestSearchViewController: XCTestCase {
    
    //Initialize SearchViewController
    let vc = SearchViewController() //Dependency ရှိရင် Inject လုပ်ပေးရမယ်။ အမြင်သာဆုံးက Presenter ဖြစ်မယ်။
 
    func test_xxx {
 
    }
 }

 လက်ရှိ SearchViewController မှာ Test လုပ်စရာ Logic ကြီးကြီးမားမားမရှိ
 
 viewDidLoad => Object Instantiate လုပ်ရင်ခေါ်တဲ့အတွက် စမ်းလို့ရ
 mPresenter နဲ့သက်ဆိုင်တဲ့ Method တွေခေါ်/မခေါ်စမ်းဖို့အတွက် Presenter ကို Mock လုပ်ဖို့လို
 ကျန်တဲ့ statement တွေသည် framework component ဖြစ်တဲ့အတွက် Test လုပ်ဖို့မလို။ ဥပမာ self.present | view.addSubView | etc...
 */
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
        
        /**
         
         navigateToMovieDetail method implementation already exists in SearchViewController
         ခုဒီမှာ Logic တွေကို ပြန်ရေးထားသလိုဖြစ်နေတယ်။
         
         */
        //        let vc = MockDetailViewController()
        //if let vc = vc {
        //            vc.movie = movie
        //            XCTAssertEqual(movie.id, 547016)
        //            vc.modalPresentationStyle = .fullScreen
        //            self.present(vc, animated: true, completion: nil)
        //}
    }
    
    
}

