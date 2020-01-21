//
//  Movie.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 17/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

struct ListMovie: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    
    let posterPath: String
    let title: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    let backdropPath: String
    
    init(posterPath: String, title: String, voteAverage: Float, overview: String, releaseDate: String, backdropPath: String) {
        self.posterPath = posterPath
        self.title = title
        self.voteAverage = voteAverage
        self.overview = overview
        self.releaseDate = releaseDate
        self.backdropPath = backdropPath
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let title: String = try container.decode(String.self, forKey: .title)
        let voteAverage: Float = try container.decode(Float.self, forKey: .voteAverage)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let releaseDate: String = try container.decode(String.self, forKey: .releaseDate)
        let backdropPath: String = try container.decode(String.self, forKey: .backdropPath)
        self.init(posterPath: posterPath, title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, backdropPath: backdropPath)
    }
}
