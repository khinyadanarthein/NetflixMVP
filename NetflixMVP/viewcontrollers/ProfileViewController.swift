//
//  ProfileViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 05/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var imageViewUserPhoto: UIImageView!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var collectionViewWatchList: UICollectionView!
    @IBOutlet weak var collectionViewRateList: UICollectionView!
    
    static var identifier : String {
        return "ProfileViewController"
    }
    
    var mPresenter : ProfilePresenter = ProfilePresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initIndicator()
        initDataObservationMVP()
        registerView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        if !UserDefaultUtil.shared.retrieveIsLogin() {
            self.navigateToLogin()
        } else {
            mPresenter.onUIReady()
        }
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        
        if !UserDefaultUtil.shared.retrieveIsLogin() {
            self.navigateToLogin()
        } else {
            mPresenter.onUIReady()
        }
    }
    
    func registerView() {
        
        collectionViewRateList.register(UINib(nibName: SimilarMoviesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SimilarMoviesCollectionViewCell.identifier)
        
        collectionViewWatchList.register(UINib(nibName: SimilarMoviesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SimilarMoviesCollectionViewCell.identifier)
        
        collectionViewRateList.dataSource = self
        collectionViewRateList.delegate = self
        collectionViewWatchList.dataSource = self
        collectionViewWatchList.delegate = self
        
        self.labelUserName.text = UserDefaultUtil.shared.retrieveUserName()
        
        self.imageViewUserPhoto.layer.borderColor = UIColor.lightGray.cgColor
        self.imageViewUserPhoto.layer.borderWidth = 1
    }
    
}

extension ProfileViewController : ProfileView {
    
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
    
    func showAccountDetail(data: AccountDetailResponse) {
        self.mPresenter.accountInfo = data
        self.labelUserName.text = data.username
    }
    
    func showRatedMovies(data: [RateMovieVO]) {
        self.mPresenter.ratedMovieList = data
        self.collectionViewRateList.reloadData()
    }
    
    func showWatchedMovies(data: [WatchMovieVO]) {
        self.mPresenter.watchedMovieList = data
        self.collectionViewWatchList.reloadData()
    }

}

extension ProfileViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewWatchList {
            return mPresenter.watchedMovieList.count
        }
        return mPresenter.ratedMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionViewWatchList {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCollectionViewCell.identifier, for: indexPath) as? SimilarMoviesCollectionViewCell {
                cell.posterPath = self.mPresenter.watchedMovieList[indexPath.row].posterPath
                return cell
            }
            
        }
        
        if collectionView == self.collectionViewRateList {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCollectionViewCell.identifier, for: indexPath) as? SimilarMoviesCollectionViewCell {
                cell.posterPath = self.mPresenter.ratedMovieList[indexPath.row].posterPath
                return cell
            }
            
        }
        
        return UICollectionViewCell()
    }
    
    
}
extension ProfileViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionViewWatchList {
            return CGSize(width: 130, height: 180)
        }
        return CGSize(width: 130, height: 180)
    }

}
