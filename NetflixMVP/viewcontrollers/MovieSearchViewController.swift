//
//  MovieSearchViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 03/06/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

class MovieSearchViewController: UIViewController {

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
        collectionViewMovieResult.register(UINib(nibName: SearchMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchMovieCollectionViewCell.identifier)
        
        
    }
}
extension MovieSearchViewController : MovieSearchView {
    
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
    
}

extension MovieSearchViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mPresenter.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SearchMovieCollectionViewCell.self), for: indexPath) as? SearchMovieCollectionViewCell else { return UICollectionViewCell() }
        cell.mData = self.mPresenter.movieList[indexPath.row]
        return cell
    }
}

extension MovieSearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.view.frame.size.width - 20) / 3) - 10
        return CGSize(width: width, height: 200)
    }
}
