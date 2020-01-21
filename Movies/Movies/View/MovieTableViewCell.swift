//
//  TableViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 16/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     weak var delegate: MovieCollectionViewCellDelegate?
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var popularMovies = [Movie]()
    
    func cellConfiguration(name: String) {
        label.text = name
    }
    
    func setupCollectionView(id: Int) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCollectionViewCell")
        
        NetworkService().fetchGenreMovies(id: id) {movies in
            guard let movie = movies else { return }
            self.popularMovies = movie
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = Int(popularMovies.count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCollectionViewCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let linkImage = "https://image.tmdb.org/t/p/w342\(popularMovies[indexPath.row].posterPath)"
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
        delegate?.cellTapped(movie: popularMovies[indexPath.row])
    }
    }
    
}
