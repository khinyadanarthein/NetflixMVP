//
//  CustomMovieSearchViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 28/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

class CustomMovieSearchViewController: UIViewController {

        @IBOutlet weak var tfMovieName: UITextField!
        @IBOutlet weak var ivClearBtn: UIImageView!
        
        @IBOutlet weak var collectionViewMovieResult: UICollectionView!
        
        var mPresenter : MovieSearchPresenter = MovieSearchPresenterImpl()
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        let disposebag : DisposeBag = DisposeBag()
          
        override func viewDidLoad() {
            super.viewDidLoad()
            initIndicator()
            initDataObservationMVP()
            initView()

            let movieName = tfMovieName.rx.text
            
            movieName.asObservable()
                .delay(RxTimeInterval.seconds(2), scheduler: MainScheduler.instance)
                   .subscribe(onNext:{ movie in
                    if !(movie?.isEmpty ?? false) {
                        self.mPresenter.onUIReady(movieName: movie!)
                    }
                   })
                   .disposed(by: disposebag)
            
            ivClearBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clearTapped(tapGestureRecognizer:))))
        }
        
        @objc func clearTapped(tapGestureRecognizer: UITapGestureRecognizer)
        {
            tfMovieName.text = ""
            
        }
        
        fileprivate func initIndicator() {
            activityIndicator.center = view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            view.addSubview(activityIndicator)
        }
        
        fileprivate func initDataObservationMVP() {
            mPresenter.attachView(view: self)
        }
        
        private func initView() {
            
            tfMovieName.attributedPlaceholder = NSAttributedString(string: "Movie Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            collectionViewMovieResult.delegate = self
            collectionViewMovieResult.dataSource = self
            
            //TODO: - register cells
            collectionViewMovieResult.register(CustomSearchCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomSearchCollectionViewCell.self))
        }
    }
    extension CustomMovieSearchViewController : MovieSearchView {
        
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
            self.collectionViewMovieResult.reloadData()
        }
        
        func navigateToMovieDetail(movie: MovieDetailVO) {
            let vc = CustomMovieDetailViewController(nibName: "CustomMovieDetailViewController", bundle: nil)
            vc.movie = movie
            print("movie id \(movie.id)")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
    }

    extension CustomMovieSearchViewController : UICollectionViewDataSource{
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.mPresenter.movieList.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomSearchCollectionViewCell.self), for: indexPath) as? CustomSearchCollectionViewCell else { return UICollectionViewCell() }
            cell.mData = self.mPresenter.movieList[indexPath.row]
            return cell
        }
    }

    extension CustomMovieSearchViewController : UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = ((self.view.frame.size.width - 20) / 3) - 10
            return CGSize(width: width, height: 200)
        }
    }

    extension CustomMovieSearchViewController : UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
            self.mPresenter.onTapMovie(data: self.mPresenter.movieList[indexPath.row])
        }
    }
