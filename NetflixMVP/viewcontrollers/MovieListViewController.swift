//
//  ViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 01/05/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum HomeSection : Int {
    case Trending = 0
    case NowPlaying = 1
    case Upcoming = 2
    case TopRated = 3
}

class MovieListViewController: UIViewController {

    @IBOutlet weak var tableViewHome: UITableView!
    
    let bag = DisposeBag()
    var mPresenter : HomeMoviePresenter = HomeMoviePresenterImpl()
    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    //var delegate : UITabBarControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        //self.delegate = self
        initIndicator()
        initView()
        initDataObservationMVP()
    }
    
    fileprivate func initIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    fileprivate func initDataObservationMVP() {
        mPresenter.attachView(view: self)
        mPresenter.onUIReady()
    }
    
    private func initView() {
            
            tableViewHome.delegate = self
            tableViewHome.dataSource = self
    //        tableViewHome.allowsSelection = false
    //        tableViewHome.separatorStyle = .none
            
            //TODO: - register cells
        tableViewHome.register(UINib(nibName: TrendingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TrendingTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: NowPlayingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NowPlayingTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: UpcomingTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: UpcomingTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: TopRatedTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TopRatedTableViewCell.identifier)
        
        tableViewHome.register(UINib(nibName: TitleTableViewCell.identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: TitleTableViewCell.identifier)
           
    }
}

extension MovieListViewController : MovieListView {
    func navigateToMovieDetail(movie: MovieDetailVO) {
        self.navigateToDetail(movie: movie)
    }
    
    func showNowPlayingMovies(data: [NowPlayingMovieVO]) {
        self.mPresenter.nowPlayingMovie = data
        self.tableViewHome.reloadData()
    }
    
    func showTopRatedMovies(data: [TopRatedMovieVO]) {
        self.mPresenter.topRatedMovie = data
        self.tableViewHome.reloadData()
    }
    
    func showTrendingMovies(data: [TrendingMovieVO]) {
        self.mPresenter.trendingMovie = data
        self.tableViewHome.reloadData()
    }
    
    func showUpcomingMovies(data: [UpcomingMovieVO]) {
        self.mPresenter.upComingMovie = data
        self.tableViewHome.reloadData()
    }
    
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
}

extension MovieListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case HomeSection.Trending.rawValue:
            if let trendCell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as? TrendingTableViewCell {
                trendCell.trendingMovieList = mPresenter.trendingMovie
                trendCell.mDelegate = self
                return trendCell
            }
        case HomeSection.NowPlaying.rawValue:
            if let nowPlayCell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.identifier, for: indexPath) as? NowPlayingTableViewCell {
                nowPlayCell.nowPlayMovieList = mPresenter.nowPlayingMovie
                nowPlayCell.mDelegate = self
                return nowPlayCell
            }
        case HomeSection.Upcoming.rawValue:
            if let upcomingCell = tableView.dequeueReusableCell(withIdentifier: UpcomingTableViewCell.identifier, for: indexPath) as? UpcomingTableViewCell {
                upcomingCell.upcomingMovieList = mPresenter.upComingMovie
                upcomingCell.mDelegate = self
                return upcomingCell
            }
        case HomeSection.TopRated.rawValue:
            if let topRatedCell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as? TopRatedTableViewCell {
                topRatedCell.topRatedMovieList = mPresenter.topRatedMovie
                topRatedCell.mDelegate = self
                return topRatedCell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let titleCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: TitleTableViewCell.self)) as? TitleTableViewCell {
            switch section {
            case HomeSection.Trending.rawValue:
                titleCell.labelTitle.text = "Trending"
                
            case HomeSection.NowPlaying.rawValue:
                titleCell.labelTitle.text = "Now Playing"
                
            case HomeSection.Upcoming.rawValue:
                titleCell.labelTitle.text = "Upcoming"
                
            case HomeSection.TopRated.rawValue:
                titleCell.labelTitle.text = "Top Rated"
            default:
                break
            }
            return titleCell
        }
        return UITableViewCell()
    }
}

extension MovieListViewController : MovieDelegate {
    func onTapMovie(id: Int) {
        //self.navigateToMovieDetail(id: id)
        mPresenter.onTapMovie(id: id)
    }
    
}

extension MovieListViewController : UITableViewDelegate {
    
}
//
extension MovieListViewController : UITabBarControllerDelegate {

    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")

    }

}
