//
//  MainTabBarViewController.swift
//  MediaProject
//
//  Created by cho on 2/2/24.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieVC = UINavigationController(rootViewController: MovieViewController())
        let dramaVC = UINavigationController(rootViewController: MediaViewController())
        
        movieVC.tabBarItem = UITabBarItem(title: "영화", image: UIImage(systemName: "film"), tag: 0)
        dramaVC.tabBarItem = UITabBarItem(title: "드라마", image: UIImage(systemName: "play.tv"), tag: 1)

        tabBar.barTintColor = .black
        tabBar.tintColor = .white
        viewControllers = [dramaVC, movieVC]
    }

}
