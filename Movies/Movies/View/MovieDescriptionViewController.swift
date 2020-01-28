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

struct Description {
    let id: Int
}

class MovieDescriptionViewController: UIViewController {
    
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
    @IBOutlet weak var button: UIButton!
    
    var id: Int?
    var movieDescription: MovieDescription?
    var isFavorite = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovieDescription()
        configButton()
        animationFavorites()
    }
    
    func configButton() {
        more.clipsToBounds = true
        more.layer.cornerRadius = more.frame.height / 2
    }
    
    func animationFavorites() {
        animation.play(fromFrame: 0, toFrame: 32)
    }
    
    @IBAction func clickAnimation(_ sender: Any) {
        if isFavorite {
            animation.play(fromFrame: 80, toFrame: 110, loopMode: .playOnce) { _ in
                self.animation.play(fromFrame: 5, toFrame: 32)
                
            }
        } else {
            animation.play(fromFrame: 33, toFrame: 65)
        }
        
        isFavorite.toggle()
    }
    
    func setupMovieDescription() {
        movieDescription { movieDescription in
            guard let movieDescription = self.movieDescription else { return }
            self.movieDescription = movieDescription
            DispatchQueue.main.async {
                self.synopsis.text = self.movieDescription?.overview
                self.name.text = self.movieDescription?.title
                self.tagline.text = self.movieDescription?.tagline
                let fontSize: CGFloat = 20
                let text = NSMutableAttributedString(string: "Data de Lançamento: ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
                text.append(NSAttributedString(string: self.convertDateFormater(movieDescription.releaseDate), attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
                self.releaseDate.attributedText = text
                let imageBackground = "https://image.tmdb.org/t/p/w342\(movieDescription.backdropPath)"
                self.imageBackground.sd_setImage(with: URL(string: imageBackground))
                self.imageCover.sd_setImage(with: movieDescription.posterURL)
                self.starEvaluation(nota: movieDescription.voteAverage)
                self.ageRange(parentalRating: movieDescription.adult)
            }
        }
    }
    
    func ageRange(parentalRating: Bool) {
        if parentalRating == true {
            ageRange.image = UIImage(named: "proibido")
        } else {
            ageRange.image = UIImage(named: "livre")
        }
    }
    
    func starEvaluation(nota: Float) {
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
    
    func movieDescription(completion: @escaping( _ movieDescription: MovieDescription?) -> Void) {
        guard let id = id else { return }
        NetworkService().fetchMovieDescription(id: id) {movieDescription in
            guard let movieDescription = movieDescription else { return }
            self.movieDescription = movieDescription
            completion(movieDescription)
        }
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let newDate = dateFormatter.date(from: date) else { return date }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return  formatter.string(from: newDate)
        
    }
    
    @IBAction func ClickButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
