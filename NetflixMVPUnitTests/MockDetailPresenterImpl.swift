//
//  MockDetailPresenterImpl.swift
//  NetflixMVPUnitTests
//
//  Created by Khin Yadanar Thein on 30/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//




/*
 
 Presenter ကို Test လုပ်တယ်ဆိုတာ Presenter ထဲမှာရှိတဲ့ Logic တွေကို စစ်တာ
 For example
 
 
 
 */


import XCTest
@testable import NetflixMVP
@testable import RxSwift


class DetailPresenterImplTest: XCTestCase {
    
    var presenter: MovieDetailPresenterImpl!
    var view : MockMovieDetailsView!
    var dataModel : MockDataModelImpl!
    
    
    //Test Case တစ်ခုရေးတိုင်း Object အသစ်ဆောက်တဲ့ Code ပြန်ရေးဖို့မလိုပါ။ For Details => Please Option Click to read more.
    override func setUp() {
        super.setUp()
        
        //Initalize Presenter
        presenter = MovieDetailPresenterImpl()
        
        //Initialize MockMovieDetailsView
        self.view = MockMovieDetailsView()
        presenter.mView = view
        
        //Initialize DataModel
        self.dataModel = MockDataModelImpl.shared
        presenter.model = dataModel
    }
    
    func test_onUIReady_positiveCase() {
        //သုံးပိုင်းရှိမယ်။
        // 1) mView?.showLoading()
        // 2) model.getSimilarMovie(id: movieId)
        // 3) model.getSimilarMovieObservable()
        
        //mView?.showLoading() ကိုစစ်ဖို့အတွက် MovieDetailView ကို Implement လုပ်ထားတဲ့ Object တစ်ခု Create လုပ်မယ်။

        presenter.onUIReady(movieId: 1)
        
        //MovieDetailPresenterImpl class မှာ ရေးထားတဲ့ Logic တွေအရ စစ်လို့ရမယ့် Point
        /**
         mView ထဲက check လုပ်ဖို့လိုမယ့် attributes
         => isShowingLoading
         => similarMovies
         
         presenter ထဲက check လုပ်ဖို့လိုမယ့် attributes
         => similarMovies
         */
        
        XCTAssertEqual(view.isShowingLoading, false) //Success ဖြစ်တဲ့ Case မှာဆိုရင် Loading ပျောက်သွားမယ်။
        XCTAssertGreaterThan(view.similarMovies.count, 0) //Smiliar Movie List Count Must Be Greater Than One
        XCTAssertGreaterThan(presenter.similarMovies.count, 0) //Presenter ထဲက attribute ကိုလည်း assign လုပ်ထားတဲ့အတွက်ကြောင့်စစ်ပေးဖို့လိုမယ်။
        
        //Success Case ကို စစ်ပြီးရင် Failure Case ကိုစစ်ပေးဖို့လိုမယ်။
    }
    
    
    func test_onUIReady_negativeCase() {
        //Mock DataModel to Return Error Data
        self.dataModel.shouldReturnErrorData = true
        
        presenter.onUIReady(movieId: 1)
     
        //MovieDetailPresenterImpl class မှာ ရေးထားတဲ့ Logic တွေအရ စစ်လို့ရမယ့် Point
        /**
         mView ထဲက check လုပ်ဖို့လိုမယ့် attributes
         => isShowingLoading
         => similarMovies
         => Error Message Title
         => Error Message Body
         
         presenter ထဲက check လုပ်ဖို့လိုမယ့် attributes
         => similarMovies
         */
        
        XCTAssertEqual(view.isShowingLoading, false) //Failure ဖြစ်တဲ့ Case မှာဆိုရင် Loading ပျောက်သွားမယ်။
        XCTAssertEqual(view.similarMovies.count, 0) //Error တတ်တဲ့အတွက်ကြောင့် Zero Count ဖြစ်မယ်။
        XCTAssertEqual(presenter.similarMovies.count, 0) //Error တတ်တဲ့အတွက်ကြောင့် Zero Count ဖြစ်မယ်။
        XCTAssertEqual(view.errorMsgTitle, "Loding Error")//Presenter မှာ ပြန်ပေးထားတဲ့ Error အတိုင်း
        XCTAssertEqual(view.errorMsgBody, "The operation couldn’t be completed. (NetflixMVPUnitTests.MockError error 1.)")//Presenter မှာ ပြန်ပေးထားတဲ့ Error အတိုင်း
    }
    
    override func tearDown() {
        super.tearDown()
        
        //Reset to default value
        self.dataModel.shouldReturnErrorData = false
    }
    
    /**
     
     TODO:
     ကျန်တဲ့ Method ဆက်ပြီး Test လုပ်ဖို့ပါ
     => getMovieVideo()
     => rateMovie()
     => addWatchMovie()
     => attachView()
     => deattachView()
     
     ပြီးရင် MovieDetailPresenterImpl Test Coverage 100% ဖြစ်နေပါမယ်။ 
     */
}


class MockMovieDetailsView : MovieDetailView {
    
    var isShowingLoading = false
    var errorMsgTitle = ""
    var errorMsgBody = ""
    var movieDetails : MovieDetailVO?
    var similarMovies = [SimilarMovieVO]()
    var msgRatedMovie = ""
    var msgMovieWatchListAdded = ""
    var movieVideoVO : MovieVideoVO?
    
    func showLoading() {
        isShowingLoading = true
    }
    
    func hideLoading() {
        isShowingLoading = false
    }
    
    func showErrorMessage(title: String, err: String) {
        errorMsgTitle = title
        errorMsgBody = err
    }
    
    func showMovieDetail(data: MovieDetailVO) {
        movieDetails = data
    }
    
    func showSimilarMovieList(movies: [SimilarMovieVO]) {
        similarMovies = movies
    }
    
    func ratedMovie(message: String) {
        msgRatedMovie = message
    }
    
    func addWatchedMovie(message: String) {
        msgMovieWatchListAdded = message
    }
    
    func loadMovieVideo(data: MovieVideoVO) {
        movieVideoVO = data
    }
}

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
