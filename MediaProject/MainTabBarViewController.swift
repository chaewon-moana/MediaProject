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

        let tabbar = UITabBarController()
        
        let mediaVC = UINavigationController(rootViewController: MediaViewController())
        let dramaVC = UINavigationController(rootViewController: DramaViewController())
        
        mediaVC.tabBarItem = UITabBarItem(title: "미디어", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        dramaVC.tabBarItem = UITabBarItem(title: "드라마", image: UIImage(systemName: "person"), tag: 1)
        
        tabBar.barTintColor = .yellow
        tabBar.tintColor = .white
        viewControllers = [mediaVC, dramaVC]
    }

}
