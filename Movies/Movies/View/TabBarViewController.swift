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

        self.view.backgroundColor = .white
        
        setupTabBar()

    }
    
    func setupTabBar() {
    
         let movieController = UINavigationController(rootViewController: MovieViewController(nibName: "MovieViewController", bundle: nil))
        movieController.tabBarItem.image = UIImage(named: "film")
        movieController.setNavigationBarHidden(true, animated: false)
        movieController.tabBarItem.title = "Filmes"
        
        let seriesController = UINavigationController(rootViewController: SeriesViewController(nibName: "SeriesViewController", bundle: nil))
        
        seriesController.tabBarItem.image = UIImage(named: "video")
        seriesController.setNavigationBarHidden(true, animated: false)
        seriesController.tabBarItem.title = "Séries"

        let favoritesController = UINavigationController(rootViewController: FavoritesViewController(nibName: "FavoritesViewController", bundle: nil))
        favoritesController.tabBarItem.image = UIImage(named: "star")
        favoritesController.setNavigationBarHidden(true, animated: false)
        favoritesController.tabBarItem.title = "Favoritos"
        
        let profileController = UINavigationController(rootViewController: ProfileViewController(nibName: "ProfileViewController", bundle: nil))
        profileController.tabBarItem.image = UIImage(named: "male")
        profileController.setNavigationBarHidden(true, animated: false)
        profileController.tabBarItem.title = "Perfil"

        self.viewControllers = [movieController, seriesController, favoritesController, profileController]
        selectedIndex = 0
    }

}
