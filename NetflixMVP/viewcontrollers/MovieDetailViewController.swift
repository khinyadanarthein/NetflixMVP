//
//  MovieDetailViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 28/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import WebKit
import YoutubePlayer_in_WKWebView

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var ivBackPhoto: UIImageView!
    @IBOutlet weak var ivCloseBtn: UIImageView!
    @IBOutlet weak var ivPosterImage: UIImageView!
    
    @IBOutlet weak var lbReleaseDate: UILabel!
    @IBOutlet weak var lbAdault: UILabel!
    @IBOutlet weak var lbRunTime: UILabel!
    
    @IBOutlet weak var btnPlayTrailer: UIButton!
    @IBOutlet weak var youtubelayerView: WKYTPlayerView!
    @IBOutlet weak var ytPlayerHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var lbOverview: UILabel!
    
    @IBOutlet weak var stackViewMyList: UIStackView!
    @IBOutlet weak var stackViewRate: UIStackView!
    @IBOutlet weak var collectionViewSimilarMovie: UICollectionView!
    
    var id : Int!
    var movie : MovieDetailVO?
    
    var mPresenter : MovieDetailPresenter = MovieDetailPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initIndicator()
        initDataObservationMVP()
        registerView()
        
        btnPlayTrailer.layer.cornerRadius = 5
        btnPlayTrailer.layer.masksToBounds = true
        ytPlayerHeightConstant.constant = 0
        ivCloseBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeTapped(tapGestureRecognizer:))))
        stackViewMyList.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedMyList(tapGestureRecognizer:))))
        stackViewRate.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedRated(tapGestureRecognizer:))))
        
    }
    
    @objc func closeTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        mPresenter.deattachView()
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onTappedPlayTrailer(_ sender: Any) {
        mPresenter.getMovieVideo(movieId: self.movie?.id ?? 0)
    }
    
    @objc func onTappedMyList(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UserDefaultUtil.shared.retrieveIsLogin() {
            mPresenter.addWatchMovie(movieId: self.movie?.id ?? 0)
        
        } else {
            self.showErrorMessage(title: "Profile", err: "Please login first.")
        }
        
    }
    
    @objc func onTappedRated(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if UserDefaultUtil.shared.retrieveIsLogin() {
            mPresenter.rateMovie(movieId: self.movie?.id ?? 0)
        
        } else {
            self.showErrorMessage(title: "Profile", err: "Please login first.")
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
        mPresenter.onUIReady(movieId: self.movie!.id)
        self.bindData(movie: self.movie!)
    }
    
    fileprivate func bindData(movie : MovieDetailVO) {
        
        //let data = RealmHelper.shared.getMovieDetailById(id: self.id)
        
        //if let movie = data {
        
        let imageURL = IMAGE_URL_PATH + movie.posterPath
        let url = URL(string: imageURL)
        ivBackPhoto.kf.indicatorType = .activity
        ivBackPhoto.kf.setImage(
            with: url,
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.flipFromLeft(1)),
                .cacheOriginalImage
        ])
        ivPosterImage.kf.indicatorType = .activity
        ivPosterImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "logo"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.flipFromLeft(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                _ = value.source.url
            //print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Detail Job failed: \(error.localizedDescription)")
            }
        }
        
        self.lbAdault.text = movie.adult ? "+18" : "NR"
        self.lbReleaseDate.text = movie.releaseDate
        self.lbOverview.text = movie.overview
        
        if  movie.runtime != 0 {
            let runtime = Utils.shared.minutesToHoursMinutes(minutes: movie.runtime)
            self.lbRunTime.text = "\(runtime.hours)hr \(runtime.leftMinutes)min"
            
        } else {
            self.lbRunTime.text = ""
        }
            
        //}
    }
    
    func registerView() {

         collectionViewSimilarMovie.register(UINib(nibName: SimilarMoviesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SimilarMoviesCollectionViewCell.identifier)
         
         collectionViewSimilarMovie.dataSource = self
         collectionViewSimilarMovie.delegate = self
        
    }
    
}

extension MovieDetailViewController : MovieDetailView {
    func showSimilarMovieList(movies: [SimilarMovieVO]) {
        self.mPresenter.similarMovies = movies
        self.collectionViewSimilarMovie.reloadData()
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
        bindData(movie: data)
    }
    
    func ratedMovie(message: String) {
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    func addWatchedMovie(message: String) {
        self.showToast(message: message, font: .systemFont(ofSize: 12.0))
    }
    
    func loadMovieVideo(data: MovieVideoVO) {
        ytPlayerHeightConstant.constant = 150
        print(data.key ?? "")
        self.youtubelayerView.load(withVideoId: data.key ?? "")
    }
}

extension MovieDetailViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mPresenter.similarMovies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMoviesCollectionViewCell.identifier, for: indexPath) as? SimilarMoviesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.mData = self.mPresenter.similarMovies[indexPath.row]
        return cell
    }
    
}
extension MovieDetailViewController : UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 180)
    }

}
