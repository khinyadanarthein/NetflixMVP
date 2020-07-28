//
//  CustomSearchViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 27/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift

class CustomSearchViewController: UIViewController {
    
    let searchFieldView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    let searchStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 7
        stackView.distribution = .fill
        return stackView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.text = "Movies & TV"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        
        return label
    }()
    
    let searchImageView : UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "magnifyingglass")
        view.tintColor = .gray
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let tfMovieName: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .none
        textField.textColor = .lightText
        textField.textAlignment = .left
        textField.font = UIFont.systemFont(ofSize: 15)
        return textField
    }()
    
    let ivClearBtn: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "xmark.circle.fill")
        view.tintColor = .lightGray
        view.isUserInteractionEnabled = true
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()
    
    var collectionViewMovieResult : UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .black
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .vertical
            //layout.minimumLineSpacing = CGFloat(10)
            layout.sectionInset.left = CGFloat(10)
            layout.sectionInset.right = CGFloat(10)
            
        }
        
        return collectionView
    }()
    
    var mPresenter : MovieSearchPresenter = MovieSearchPresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    let disposebag : DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCustomView()
        initView()
        initIndicator()
        initDataObservationMVP()
        
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
    
    func initCustomView() {
        
        self.view.addSubview(searchFieldView)
        self.searchFieldView.addSubview(searchStackView)
        searchStackView.addArrangedSubview(searchImageView)
        searchStackView.addArrangedSubview(tfMovieName)
        searchStackView.addArrangedSubview(ivClearBtn)
        self.view.addSubview(titleView)
        self.titleView.addSubview(label)
        
        NSLayoutConstraint.activate([
            searchFieldView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            searchFieldView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            searchFieldView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10),
            searchFieldView.heightAnchor.constraint(equalToConstant: 35),
            
            searchStackView.leadingAnchor.constraint(equalTo: self.searchFieldView.leadingAnchor, constant: 0),
            searchStackView.trailingAnchor.constraint(equalTo: self.searchFieldView.trailingAnchor, constant: -5),
            searchStackView.topAnchor.constraint(equalTo: self.searchFieldView.topAnchor, constant: 0),
            searchStackView.bottomAnchor.constraint(equalTo: self.searchFieldView.bottomAnchor, constant: 0),
            
            searchImageView.heightAnchor.constraint(equalToConstant: 30),
            searchImageView.widthAnchor.constraint(equalToConstant: 30),
            ivClearBtn.heightAnchor.constraint(equalToConstant: 30),
            ivClearBtn.widthAnchor.constraint(equalToConstant: 30),
            
            titleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            titleView.heightAnchor.constraint(equalToConstant: 35),
            titleView.topAnchor.constraint(equalTo: self.searchFieldView.bottomAnchor, constant: 5),
            
            label.trailingAnchor.constraint(equalTo: self.titleView.trailingAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: self.titleView.centerYAnchor, constant: 0)
            
        ])
        self.view.addSubview(collectionViewMovieResult)
        collectionViewMovieResult.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionViewMovieResult.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionViewMovieResult.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            collectionViewMovieResult.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            collectionViewMovieResult.topAnchor.constraint(equalTo: self.titleView.bottomAnchor, constant: 10),
            collectionViewMovieResult.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            
        ])
        
    }
    
    @objc func clearTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        tfMovieName.text = ""
        
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        //activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
    }
    
    private func initView() {
        
        tfMovieName.attributedPlaceholder = NSAttributedString(string: "Movie Name",attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        collectionViewMovieResult.delegate = self
        collectionViewMovieResult.dataSource = self
        
        //TODO: - register cells
        //collectionViewMovieResult.register(UINib(nibName: SearchMovieCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SearchMovieCollectionViewCell.identifier)
        collectionViewMovieResult.register(CustomSearchCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: CustomSearchCollectionViewCell.self))
    }
}
extension CustomSearchViewController : MovieSearchView {
    
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
        //let vc = mainStoryBoard.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController
        //if let vc = vc {
            vc.movie = movie
            print("movie id \(movie.id)")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        //}
    }
}

extension CustomSearchViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mPresenter.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CustomSearchCollectionViewCell.self), for: indexPath) as? CustomSearchCollectionViewCell else { return UICollectionViewCell() }
        cell.mData = self.mPresenter.movieList[indexPath.row]
        return cell
    }
}

extension CustomSearchViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((self.view.frame.size.width - 20) / 3) - 10
        return CGSize(width: width, height: 200)
    }
}

extension CustomSearchViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.mPresenter.onTapMovie(data: self.mPresenter.movieList[indexPath.row])
    }
}
