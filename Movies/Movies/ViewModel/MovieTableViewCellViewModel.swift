//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 11/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
class MovieTableViewCellViewModel {
    var service: TheMDBAPI = TheMDBAPIImpl()
    var listGenreMovie = [Movie]()
    var id = 0
    
    func numberOfMovies() -> Int {
           return listGenreMovie.count
       }
       
       func get(at row: Int) -> URL? {
        return listGenreMovie[row].posterURL
       }
    
    func setupTableViewCell(completion : @escaping () -> Void) {
        service.fetchGenreMovies(id: id) { result in
            switch result {
            case .success(let movies):
                self.listGenreMovie = movies
                completion()
            case .failure:
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        
    }
  
}
