//
//  MainTabBarViewController.swift
//  NetflixMVP
//
//  Created by Khin Yadanar Thein on 27/07/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        buildMenuItem()
        
    }
    
    func buildMenuItem() {
        
        self.tabBar.barTintColor = .black
        self.tabBar.isTranslucent = false
        self.tabBar.tintColor = .white
        
        // Home (Movie List)
        let homeTabBar = UITabBarItem()
        homeTabBar.title = "Home"
        homeTabBar.image = UIImage(systemName: "house")
        homeTabBar.selectedImage = UIImage(systemName: "house.fill")
        
        let movieListVC = CustomMovieListViewController(nibName: "CustomMovieListViewController", bundle: nil)
        movieListVC.tabBarItem = homeTabBar
        movieListVC.tabBarItem.badgeColor = .white
        
        let movieListNavVC = UINavigationController()
        movieListNavVC.navigationBar.prefersLargeTitles = false
        movieListNavVC.navigationBar.isTranslucent = false
        movieListNavVC.navigationBar.barTintColor = .black
        movieListNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        movieListNavVC.viewControllers = [movieListVC]
        movieListVC.navigationItem.title = "Movies"
        let logo = UIBarButtonItem(image: UIImage(named: "netfilx-64"), style: .plain, target: self, action: nil)
        movieListVC.navigationItem.leftBarButtonItem  = logo
        
        // Search Movies
        let searchTabBar = UITabBarItem()
        searchTabBar.title = "Search"
        searchTabBar.image = UIImage(systemName: "magnifyingglass")
        searchTabBar.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        let searchVC = CustomMovieSearchViewController(nibName: "CustomMovieSearchViewController", bundle: nil)
        searchVC.tabBarItem = searchTabBar
        searchVC.tabBarItem.badgeColor = .white
        
        let searchNavVC = UINavigationController()
        searchNavVC.navigationBar.prefersLargeTitles = false
        searchNavVC.navigationBar.isTranslucent = false
        searchNavVC.navigationBar.barTintColor = .black
        searchNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        searchNavVC.viewControllers = [searchVC]
        searchVC.navigationItem.title = "Search Movies"
        searchVC.navigationItem.leftBarButtonItem  = logo
        
        // Profile / Login
        let profileTabBar = UITabBarItem()
        profileTabBar.title = "Profile"
        profileTabBar.image = UIImage(systemName: "person")
        profileTabBar.selectedImage = UIImage(systemName: "person.circle.fill")
        
        let profileVC = CustomProfileViewController(nibName: "CustomProfileViewController", bundle: nil)
        //let profileVC = CustomProfileViewController()
        profileVC.tabBarItem = profileTabBar
        profileVC.tabBarItem.badgeColor = .white
        
        let profileNavVC = UINavigationController()
        profileNavVC.navigationBar.prefersLargeTitles = false
        profileNavVC.navigationBar.isTranslucent = false
        profileNavVC.navigationBar.barTintColor = .black
        profileNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        profileNavVC.viewControllers = [profileVC]
        
        profileVC.navigationItem.title = "Profile"
        profileVC.navigationItem.leftBarButtonItem = logo
        
        self.setViewControllers([
            movieListNavVC
            ,searchNavVC
            ,profileNavVC
        ], animated: true)
    }
}
