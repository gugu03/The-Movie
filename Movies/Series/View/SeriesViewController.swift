//
//  SeriesViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 15/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class SeriesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SerieCollectionViewCellDelegate {
    
    var serieViewModel: SerieViewModel = SerieViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSeriesTableView()
        serieViewModel.setupSeriesTableView {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
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
       
    }
    
    func cellTapped(serie: Serie) {
        let serieDescriptionViewController = SerieDescriptionViewController(nibName: "SerieDescriptionViewController", bundle: nil)
        serieDescriptionViewController.serieDescriptionViewModel.id = serie.id
        present(serieDescriptionViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieViewModel.numberOfSerie()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if let cell = cell as? SeriesTableViewCell {
            cell.cellConfiguration(name: serieViewModel.getSerie(at: indexPath.row).0)
            cell.serieTableViewCellViewModel.id = serieViewModel.getSerie(at: indexPath.row).1
            cell.setupCollectionView()
            cell.delegate = self
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = 170
        return   CGFloat(height)}
    
}
