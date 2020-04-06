//
//  FavoriteViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 14/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var favoriteViewModel = FavoriteViewModel()
    
    @IBOutlet weak var favoritoSeriesCollectionView: UICollectionView!
    @IBOutlet weak var favoretoMovieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteViewModel.dataMovie {
            self.setupMovieCollectionView()
        }
        favoriteViewModel.dataSerie {
            self.setupSerieCollectionView()
        }
    }
    
    func setupMovieCollectionView() {
        favoretoMovieCollectionView.delegate = self
        favoretoMovieCollectionView.dataSource = self
        favoretoMovieCollectionView.register(UINib(nibName: "FavoriteMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "favoriteMoviesCollectionViewCell")
        DispatchQueue.main.async {
            self.favoretoMovieCollectionView.reloadData()
        }
        
    }
    
    func setupSerieCollectionView() {
           favoritoSeriesCollectionView.delegate = self
           favoritoSeriesCollectionView.dataSource = self
           favoritoSeriesCollectionView.register(UINib(nibName: "FavoriteSeriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "favoriteSerieCollectionViewCell")
           DispatchQueue.main.async {
               self.favoritoSeriesCollectionView.reloadData()
           }
           
       }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case favoretoMovieCollectionView:
            let count = favoriteViewModel.movie.count
            return count
        case favoritoSeriesCollectionView:
            let count = favoriteViewModel.serie.count
            return count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 205
        let height = 273
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case favoretoMovieCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteMoviesCollectionViewCell", for: indexPath)
            if let cell = cell as? FavoriteMoviesCollectionViewCell {
                cell.setupImage(posterPath: favoriteViewModel.movie[indexPath.row].posterPath ?? "")
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favoriteSerieCollectionViewCell", for: indexPath)
            if let cell = cell as? FavoriteSeriesCollectionViewCell {
                cell.setupImage(posterPath: favoriteViewModel.serie[indexPath.row].posterPath ?? "")
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == favoretoMovieCollectionView {
            
            let movieDescriptionViewModel = MovieDescriptionViewModel(id: favoriteViewModel.movie[indexPath.row].id ?? 0)
            
              let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
            
              present(movieDescriptionViewController, animated: true, completion: nil)
            
        } else {
        let serieDescriptionViewController = SerieDescriptionViewController(nibName: "SerieDescriptionViewController", bundle: nil)
            
            serieDescriptionViewController.serieDescriptionViewModel.id = favoriteViewModel.serie[indexPath.row].id
            
            present(serieDescriptionViewController, animated: true, completion: nil)
            
        }
    }
    
}
