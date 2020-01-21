//
//  GenreSeries.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
struct SeriesGenreList: Decodable {
    let genres: [SerieGenre]
}

struct SerieGenre: Decodable {
    let name: String
    let id: Int
}
