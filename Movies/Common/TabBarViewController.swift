//
//  TabBarViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 15/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    func setupTabBar() {
         let movieController = UINavigationController(rootViewController: MovieViewController(nibName: "MovieViewController", bundle: nil))
        movieController.tabBarItem.image = UIImage(systemName: "film")
        movieController.tabBarItem.selectedImage = UIImage(systemName: "film.fill")
        movieController.setNavigationBarHidden(true, animated: false)
        movieController.tabBarItem.title = "Filmes"
        
        let seriesController = UINavigationController(rootViewController: SeriesViewController(nibName: "SeriesViewController", bundle: nil))
        seriesController.tabBarItem.image = UIImage(systemName: "tv")
        seriesController.tabBarItem.selectedImage = UIImage(systemName: "tv.fill")
        seriesController.setNavigationBarHidden(true, animated: false)
        seriesController.tabBarItem.title = "Séries"
        
        let favoriteController = UINavigationController(rootViewController: FavoriteViewController(nibName: "FavoriteViewController", bundle: nil))
        favoriteController.tabBarItem.image = UIImage(systemName: "heart")
        favoriteController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favoriteController.setNavigationBarHidden(true, animated: false)
        favoriteController.tabBarItem.title = "Favoritos"
        
        self.viewControllers = [movieController, seriesController, favoriteController]
        selectedIndex = 0
    }
}
