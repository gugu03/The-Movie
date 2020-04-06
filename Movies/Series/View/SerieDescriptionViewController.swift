//
//  SerieDescriptionViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 30/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit
import Lottie

class SerieDescriptionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var serieDescriptionViewModel = SerieDescriptionViewModel()
    var isFavorite = false
    
    @IBOutlet weak var animation: AnimationView!
    @IBOutlet weak var collectionViewSeasons: UICollectionView!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var episodeTime: UILabel!
    @IBOutlet weak var numberEpisodes: UILabel!
    @IBOutlet weak var numberSeasons: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var posterPath: UIImageView!
    @IBOutlet weak var backdropPath: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animationFavorites()
        configButton()
        setupCollectionView()
        animation.play(fromFrame: 0, toFrame: 32)
    }
    
    func setupCollectionView() {
        collectionViewSeasons.delegate = self
        collectionViewSeasons.dataSource = self
        collectionViewSeasons.register(UINib(nibName: "SerieDescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "serieDescriptionCollectionViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        serieDescriptionViewModel.data {
            self.isFavorite = self.serieDescriptionViewModel.isFavorite
            self.animationFavorites()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        serieDescriptionViewModel.fetchSerieDescription(success: { serieDescription in
            self.setup(serieDescription: serieDescription)
        }, failure: {})
        DispatchQueue.main.async {
            self.collectionViewSeasons.reloadData()
        }
        
    }

    func setup(serieDescription: SerieDescription?) {
        
        posterPath.sd_setImage(with: serieDescription?.posterURL)
        
        backdropPath.sd_setImage(with: serieDescription?.backdropURL)
        
        name.text = serieDescription?.name
        
        guard let sinopse = serieDescription?.overview else { return }
        episodeTime.text = "Sinopse:\n \(sinopse)"
        
        overview.text = "Temporadas:"
        
        guard let seasons = serieDescription?.numberSeasons else { return }
        numberSeasons.text = "Temporadas: \(seasons)"
        
        guard let episodes = serieDescription?.numberEpisodes else { return }
        numberEpisodes.text = "Episódios: \(episodes)"
        
        starEvaluation(nota: serieDescription?.voteAverage)
    }
    
    @IBAction func clickAnimation(_ sender: Any) {
        animationFavoritesClick(isFavorite: isFavorite)
    }
    
    @IBAction func more(_ sender: Any) {
        serieDescriptionViewModel.setupHomePage()
        guard let urlSerieDescriptionLink = serieDescriptionViewModel.urlSerieDescriptionLink else { return }
        UIApplication.shared.open(urlSerieDescriptionLink)
    }
    
    func animationFavoritesClick(isFavorite: Bool) {
        if isFavorite {
            animation.play(fromFrame: 80, toFrame: 110, loopMode: .playOnce) { _ in
                self.animation.play(fromFrame: 5, toFrame: 32)
                self.serieDescriptionViewModel.delete()
            }
        } else {
            animation.play(fromFrame: 33, toFrame: 65)
            serieDescriptionViewModel.post()
        }
        self.isFavorite.toggle()
    }
    
    func animationFavorites() {
        self.animation.play(fromFrame: 33, toFrame: 65)
    }
    
    func configButton() {
        more.clipsToBounds = true
        more.layer.cornerRadius = more.frame.height / 2
    }
    
    func starEvaluation(nota: Float?) {
        guard let nota = nota else { return }
        let media = Int(nota / 2)
        if media <= 1 {
            voteAverage.text = "★☆☆☆☆"
        } else if media <= 2 {
            voteAverage.text = "★★☆☆☆"
        } else if media <= 3 {
            voteAverage.text = "★★★☆☆"
        } else if media <= 4 {
            voteAverage.text = "★★★★☆"
        } else if media <= 5 {
            voteAverage.text = "★★★★★"
        } else {
            voteAverage.text = "☆☆☆☆☆"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = serieDescriptionViewModel.serieDescription?.seasons else { return 0 }
        return count.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "serieDescriptionCollectionViewCell", for: indexPath) as? SeriesDescriptionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupSeasons(serieDescription: serieDescriptionViewModel.serieDescription?.seasons?[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 121
        let height = 160
        return CGSize(width: width, height: height)
    }
    
}
