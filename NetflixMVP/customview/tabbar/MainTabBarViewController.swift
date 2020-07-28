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
        let movieListVC = MovieListViewController()
        movieListVC.tabBarItem = homeTabBar
        
        let movieListNavVC = UINavigationController()
        movieListNavVC.navigationBar.prefersLargeTitles = false
        movieListNavVC.viewControllers = [movieListVC]
        movieListVC.navigationItem.title = "Movies"
        
        // Search Movies
        let searchTabBar = UITabBarItem()
        searchTabBar.title = "Search"
        searchTabBar.image = UIImage(systemName: "magnifyingglass")
        searchTabBar.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        let searchVC = CustomSearchViewController()
        searchVC.tabBarItem = searchTabBar
        searchVC.tabBarItem.badgeColor = .white
        
        let searchNavVC = UINavigationController()
        searchNavVC.navigationBar.prefersLargeTitles = false
        searchNavVC.navigationBar.isTranslucent = false
        searchNavVC.navigationBar.barTintColor = .black
        searchNavVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        searchNavVC.viewControllers = [searchVC]
        searchVC.navigationItem.title = "Search Movies"
        let logo = UIBarButtonItem(image: UIImage(named: "netfilx-64"), style: .plain, target: self, action: nil) 
        searchVC.navigationItem.leftBarButtonItem  = logo
        
        // Profile / Login
        let profileTabBar = UITabBarItem()
        profileTabBar.title = "Profile"
        profileTabBar.image = UIImage(systemName: "magnifyingglass")
        profileTabBar.selectedImage = UIImage(systemName: "magnifyingglass.circle.fill")
        
        let profileVC = ProfileViewController()
        profileVC.tabBarItem = profileTabBar
        
        let profileNavVC = UINavigationController()
        profileNavVC.navigationBar.prefersLargeTitles = false
        profileNavVC.viewControllers = [profileVC]
        profileVC.navigationItem.title = "Profile"
        
        self.setViewControllers([
            //movieListVC
            searchNavVC
            //,profileNavVC
        ], animated: true)
    }
}
