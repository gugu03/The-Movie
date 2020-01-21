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
    var genreSeries = [Serie]()
    
     @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func cellConfiguration(name: String) {
        label.text = name
    }
    func setupCollectionView(id: Int) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "SerieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serieCollectionViewCell")
        
        NetworkServiceSeries().fetchGenreSerie(id: id) {serie in
            guard let serie = serie else { return }
            self.genreSeries = serie
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = Int(genreSeries.count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieCollectionViewCell", for: indexPath) as? SerieCollectionViewCell else {
                   return UICollectionViewCell()
               }
        let linkImage = "https://image.tmdb.org/t/p/w342\(genreSeries[indexPath.row].posterPath)"
        cell.image(link: linkImage)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 100
        let height = 125
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       if delegate != nil {
           delegate?.cellTapped(serie: genreSeries[indexPath.row])
       }
       }
    
}
