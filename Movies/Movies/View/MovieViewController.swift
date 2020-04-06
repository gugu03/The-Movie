//
//  ViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 12/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit
import Foundation

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MovieCollectionViewCellDelegate {
    
    var movieViewModel: MovieViewModel = MovieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        movieViewModel.setupViewController {
            self.tableView.reloadData()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "MovieTableViewCell", bundle: Bundle(for: MovieTableViewCell.self)),
            forCellReuseIdentifier: "cellId"
        )
    }
    
    func cellTapped(movie: Movie) {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: movie.id)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
        present(movieDescriptionViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfMovies() 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if let cell = cell as? MovieTableViewCell {
            cell.cellConfiguration(name: movieViewModel.getMovie(at: indexPath.row).0)
            cell.movieTableViewCellViewModel.id = movieViewModel.getMovie(at: indexPath.row).1
            cell.setupCollectionView()
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 170
        return   CGFloat(height)
    }
    
}
