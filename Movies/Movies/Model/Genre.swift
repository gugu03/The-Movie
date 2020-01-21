//
//  Genre.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 17/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

struct GenreList: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let name: String
    let id: Int
}
