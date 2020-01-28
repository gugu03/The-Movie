//
//  SeriesViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 15/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SerieCollectionViewCellDelegate {
    
@IBOutlet weak var tableView: UITableView!
 var genreSerie = [SerieGenre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeriesTableView()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSeriesTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            UINib(nibName: "SeriesTableViewCell", bundle: Bundle(for: MovieTableViewCell.self)),
            forCellReuseIdentifier: "cellId"
        )
        
        NetworkServiceSeries().fetchSerieNameGenres { serieGenre in
            guard let serieGenre = serieGenre else { return }
            self.genreSerie = serieGenre
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func cellTapped(serie: Serie) {
     let movieDescriptionViewController = MovieDescriptionViewController(nibName: "MovieDescriptionViewController", bundle: nil)
//        let descriptionType = Description(id: serie.id)
//        movieDescriptionViewController.descriptionType = descriptionType
    present(movieDescriptionViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = Int(genreSerie.count)
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if let cell = cell as? SeriesTableViewCell {
            cell.cellConfiguration(name: genreSerie[indexPath.row].name)
            cell.setupCollectionView(id: genreSerie[indexPath.row].id)
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = 170
    return   CGFloat(height)}
 
}
