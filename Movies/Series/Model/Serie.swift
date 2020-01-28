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

struct Serie: Decodable, CoisaQueTemPoster {
    
    let posterPath: String?
    let id: Int
    
    init(posterPath: String?, id: Int) {
        self.posterPath = posterPath
        self.id = id
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String? = try container.decode(String.self, forKey: .posterPath)
        let id: Int = try container.decode(Int.self, forKey: .id)
        self.init(posterPath: posterPath, id: id)
    }
}
