//
//  MovieDescriptionViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 14/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit
import SDWebImage
import Lottie
import Firebase
import FirebaseDatabase

class MovieDescriptionViewController: UIViewController {
    
    let movieDescriptionViewModel: MovieDescriptionViewModel
    
    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var more: UIButton!
    @IBOutlet weak var evaluation: UILabel!
    @IBOutlet weak var ageRange: UIImageView!
    @IBOutlet private var animation: AnimationView!
    
    var isFavorite: Bool = false
    
    init(movieDescriptionViewModel: MovieDescriptionViewModel) {
        self.movieDescriptionViewModel = movieDescriptionViewModel
        super.init(nibName: String(describing: MovieDescriptionViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configButton()
        animation.play(fromFrame: 0, toFrame: 32)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        movieDescriptionViewModel.data {
            self.isFavorite = self.movieDescriptionViewModel.isFavorite
            self.animationFavorites()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieDescriptionViewModel.fetchMovieDescription(success: { movieDescription in
            self.setup(description: movieDescription)
        }, failure: {})
    }
    
    func configButton() {
        more.clipsToBounds = true
        more.layer.cornerRadius = more.frame.height / 2
    }
    
    func animationFavorites() {
         self.animation.play(fromFrame: 33, toFrame: 65)
    }
    
    @IBAction func clickAnimation(_ sender: Any) {
        animationFavoritesClick(isFavorite: isFavorite)
    }
    
    func animationFavoritesClick(isFavorite: Bool) {
        if isFavorite {
            animation.play(fromFrame: 80, toFrame: 110, loopMode: .playOnce) { _ in
                self.animation.play(fromFrame: 5, toFrame: 32)
                self.movieDescriptionViewModel.delete()
            }
        } else {
            animation.play(fromFrame: 33, toFrame: 65)
            movieDescriptionViewModel.post()
        }
        self.isFavorite.toggle()
    }
    
    @IBAction func more(_ sender: Any) {
        guard let urlMovieDescriptionLink = movieDescriptionViewModel.urlMovieDescriptionLink else { return }
        UIApplication.shared.open(urlMovieDescriptionLink)
    }
    
    func setup(description: MovieDescription) {
        name.text = description.title ?? ""
        tagline.text = description.tagline ?? ""
        handleReleaseDate(dateRelease: description.releaseDate ?? "")
        imageBackground.sd_setImage(with: description.backdropURL)
        imageCover.sd_setImage(with: description.posterURL)
        starEvaluation(nota: description.voteAverage)
        ageRange(parentalRating: description.adult)
        
    }
    
    private func handleReleaseDate(dateRelease: String) {
        let fontSize: CGFloat = 20
        let text = NSMutableAttributedString(string: "Data de Lançamento: ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        text.append(NSAttributedString(string: movieDescriptionViewModel.convertDateFormater(String(describing: dateRelease)), attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        releaseDate.attributedText = text
    }
    
    func ageRange(parentalRating: Bool?) {
        if parentalRating == true {
            ageRange.image = UIImage(named: "proibido")
        } else {
            ageRange.image = UIImage(named: "livre")
        }
    }
    
    func starEvaluation(nota: Float?) {
        guard let nota = nota else { return }
        let media = Int(nota / 2)
        if media <= 1 {
            evaluation.text = "★☆☆☆☆"
        } else if media <= 2 {
            evaluation.text = "★★☆☆☆"
        } else if media <= 3 {
            evaluation.text = "★★★☆☆"
        } else if media <= 4 {
            evaluation.text = "★★★★☆"
        } else if media <= 5 {
            evaluation.text = "★★★★★"
        } else {
            evaluation.text = "☆☆☆☆☆"
        }
    }
}
