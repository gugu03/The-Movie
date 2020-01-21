//
//  DescriptionSeason.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 21/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
struct DescriptionSeason: Decodable {
    let posterPath: String
    let name: String
    
    init(posterPath: String, name: String) {
        self.posterPath = posterPath
        self.name = name
    }
    
    enum MovieKey: String, CodingKey {
        case posterPath = "poster_path"
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieKey.self)
        let posterPath: String = try container.decode(String.self, forKey: .posterPath)
        let name: String = try container.decode(String.self, forKey: .name)
        
        self.init(posterPath: posterPath, name: name)
    }
}
