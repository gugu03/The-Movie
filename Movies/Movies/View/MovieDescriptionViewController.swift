//
//  MovieDescriptionViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 14/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import UIKit

struct Description {
    let title: String
    let poster: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let backdropPath: String
}

class MovieDescriptionViewController: UIViewController {
    @IBOutlet weak var titleMovie: UILabel!
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var overview: UITextView!
    
    @IBOutlet weak var posterbackground: UIImageView!
    
    var descriptionType: Description?
    var descriptionmovies = [MovieDescription]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDate()
    }
    
    func setupDate() {
        guard let descriptionType = descriptionType else { return }
        
        NetworkService().fetchMovieDescription { movie in
            guard let movie = movie else { return }
            self.descriptionmovies = movie
        }
        titleMovie.text = descriptionType.title
        releaseDate.text = ("Lançamento: \(String(describing: convertDateFormater(descriptionType.releaseDate)))")
        let defaultLink = "https://image.tmdb.org/t/p/w342\(String(describing: descriptionType.poster))"
        poster.downloaded(from: defaultLink)
        poster.contentMode = .scaleAspectFit
        let poster = "https://image.tmdb.org/t/p/w342\(String(describing: descriptionType.backdropPath))"
        posterbackground.downloaded(from: poster)
        posterbackground.contentMode = .scaleAspectFill
        voteAverage.text = ("Avaliação: \(String(descriptionType.voteAverage))")
        overview.text = descriptionType.overview
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let newDate = dateFormatter.date(from: date) else { return date }
        dateFormatter.dateFormat = "dd / MM / yyyy"
        return  dateFormatter.string(from: newDate)

    }
    
    @IBAction func ClickButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
