//
//  SeriesTableViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    weak var delegate: SerieCollectionViewCellDelegate?
    var serieTableViewCellViewModel: SerieTableViewCellViewModel = SerieTableViewCellViewModel()
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func cellConfiguration(name: String) {
        label.text = name
    }
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serieCollectionViewCell")
        
        serieTableViewCellViewModel.setupSerieTableViewCell {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serieTableViewCellViewModel.numberOfSeries()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieCollectionViewCell", for: indexPath)
        if let cell = cell as? SerieCollectionViewCell {
            cell.imageSerie(url: serieTableViewCellViewModel.getSerie(at: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100
        let height = 125
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(serie: serieTableViewCellViewModel.genreSeries[indexPath.row])
        }
    }
    
}
