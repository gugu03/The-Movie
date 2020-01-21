//
//  Serie.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

struct ListSerie: Decodable {
    let results: [Serie]
}

struct Serie: Decodable {
    
    let posterPath: String
    let name: String
    let voteAverage: Float
    let overview: String
    let backdropPath: String
    
    init(posterPath: String, name: String, voteAverage: Float, overview: String, backdropPath: String) {
        self.posterPath = posterPath
        self.name = name
        self.voteAverage = voteAverage
        self.overview = overview
        self.backdropPath = backdropPath
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case name
        case voteAverage = "vote_average"
        case overview
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let name: String = try container.decode(String.self, forKey: .name)
        let voteAverage: Float = try container.decode(Float.self, forKey: .voteAverage)
        let overview: String = try container.decode(String.self, forKey: .overview)
        let backdropPath: String = try container.decode(String.self, forKey: .backdropPath)
        self.init(posterPath: posterPath, name: name, voteAverage: voteAverage, overview: overview, backdropPath: backdropPath)
    }
}
