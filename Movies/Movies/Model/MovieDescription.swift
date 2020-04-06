//
//  Description.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 20/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

protocol ConvertBackdropLink {
    var backdropPath: String? { get }
    var backdropURL: URL? { get }
}

extension ConvertBackdropLink {
    var backdropURL: URL? {
        if let backdropPath = self.backdropPath?.replacingOccurrences(of: "^/", with: "", options: .regularExpression) {
            return URL(string: backdropPath, relativeTo: URL(string: "https://image.tmdb.org/t/p/original/"))
        }
        return nil
    }
}

struct MovieDescription: Decodable, ConvertPosterLink, ConvertBackdropLink {
    let adult: Bool
    let backdropPath: String?
    let voteAverage: Float?
    let releaseDate: String?
    let overview: String?
    let tagline: String?
    let title: String?
    let homepage: String?
    let posterPath: String?
    let id: Int?
    
    init(adult: Bool, backdropPath: String?, voteAverage: Float?, releaseDate: String?, overview: String?, tagline: String?, title: String?, homepage: String?, posterPath: String?, id: Int?) {
            self.adult = adult
            self.backdropPath = backdropPath
            self.voteAverage = voteAverage
            self.releaseDate = releaseDate
            self.overview = overview
            self.tagline = tagline
            self.title = title
            self.homepage = homepage
            self.posterPath = posterPath
            self.id = id
        }
        
        enum MovieKey: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case voteAverage = "vote_average"
            case releaseDate = "release_date"
            case overview
            case tagline
            case title
            case homepage
            case posterPath = "poster_path"
            case id
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: MovieKey.self)
            let adult: Bool = try container.decode(Bool.self, forKey: .adult)
            let backdropPath: String? = try container.decode(String.self, forKey: .backdropPath)
            let voteAverage: Float? = try container.decode(Float.self, forKey: .voteAverage)
            let releaseDate: String? = try container.decode(String.self, forKey: .releaseDate)
            let overview: String? = try container.decode(String.self, forKey: .overview)
            let tagline: String? = try container.decode(String.self, forKey: .tagline)
            let title: String? = try container.decode(String.self, forKey: .title)
            let homepage: String? = try container.decode(String.self, forKey: .homepage)
            let posterPath: String? = try container.decode(String.self, forKey: .posterPath)
            let id: Int? = try container.decode(Int.self, forKey: .id)
            self.init(adult: adult, backdropPath: backdropPath, voteAverage: voteAverage, releaseDate: releaseDate, overview: overview, tagline: tagline, title: title, homepage: homepage, posterPath: posterPath, id: id)
        }
    }
