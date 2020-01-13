//
//  ViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 12/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit
import Foundation

struct  ListMovie : Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    let posterPath: String
    let title: String
    
    init(posterPath: String, title: String) {
        self.posterPath = posterPath
        self.title = title
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case title
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let title: String = try container.decode(String.self, forKey: .title)
        self.init(posterPath: posterPath, title: title)
    }
}


class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    
    // MARK: - Collections View
    @IBOutlet weak var moviePopularCollectionView: UICollectionView!
    @IBOutlet weak var movieTopRatedCollectionView: UICollectionView!
    @IBOutlet weak var upcomingReleasesCollectionView: UICollectionView!
    
    // MARK: - Label
    @IBOutlet weak var popularesLabel: UILabel!
    @IBOutlet weak var launchLabel: UILabel!
    @IBOutlet weak var launchLabel1: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Constraint Collections Views
    @IBOutlet weak var firstCollectionSize: NSLayoutConstraint!
    @IBOutlet weak var secondCollecitonSize: NSLayoutConstraint!
    
    // MARK: - Variables
    private let aspectRatio:CGFloat = 0.75
    var popularMovies = [Movie]()
    var upcomingReleases = [Movie]()
    var movieTopRated = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraint()
        setupCollections()
        fetchingCollectionsDataSource()
        
    }
    
    func fetchingCollectionsDataSource() {
        DispatchQueue.main.async {
            self.moviePopularCollectionView.reloadData()
        }
    }
    
    func setupCollections() {
        moviePopularCollectionView.dataSource = self
        moviePopularCollectionView.delegate = self
        
        movieTopRatedCollectionView.dataSource = self
        movieTopRatedCollectionView.delegate = self
        
        upcomingReleasesCollectionView.dataSource = self
        upcomingReleasesCollectionView.delegate = self
        popularMovies = NetworkService().fetchMoviePopular()
    }
    
    func setupConstraint(){
        let size = view.bounds.height - 40
        let collectionHeight:CGFloat = (size - 135)/3
        firstCollectionSize.constant = collectionHeight
        secondCollecitonSize.constant = collectionHeight
    }
    
    // MARK: - Collections View Delegate & DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = firstCollectionSize.constant
        return CGSize(width: height*aspectRatio, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieTopRatedCollectionView {
            
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieTopRated", for: indexPath) as! MovieTopRatedCollectionViewCell
            
            return cell
            
        } else if collectionView == moviePopularCollectionView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviePopular", for: indexPath) as! MoviePopularCollectionViewCell
            
            let defaultLink = "https://image.tmdb.org/t/p/w342\(popularMovies[indexPath.row].posterPath)"
            cell.poster.downloaded(from: defaultLink)
            cell.poster.contentMode = .scaleAspectFit
            return cell
            
        } else if  collectionView == upcomingReleasesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingReleases", for: indexPath) as! UpcomingReleasesCollectionViewCell
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}



