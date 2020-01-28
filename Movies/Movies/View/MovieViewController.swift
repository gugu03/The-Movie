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
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var genreMovie = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "MovieTableViewCell", bundle: Bundle(for: MovieTableViewCell.self)),
            forCellReuseIdentifier: "cellId"
        )
        
        NetworkService().fetchNameGenres { name in
            guard let name = name else { return }
            self.genreMovie = name
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func cellTapped(movie: Movie) {
        let movieDescriptionViewController = MovieDescriptionViewController(nibName: "MovieDescriptionViewController", bundle: nil)
        movieDescriptionViewController.id = movie.id
       present(movieDescriptionViewController, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Int(genreMovie.count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if let cell = cell as? MovieTableViewCell {
            cell.cellConfiguration(name: genreMovie[indexPath.row].name)
            cell.setupCollectionView(id: genreMovie[indexPath.row].id)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 170
        return   CGFloat(height)}
    
}
