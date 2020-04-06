//
//  MovieViewController.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 11/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
class MovieViewModel {
    var genreMovie = [Genre]()
    var service: TheMDBAPI = TheMDBAPIImpl()
    
    func numberOfMovies() -> Int {
        return genreMovie.count
    }
    
    func getMovie(at row: Int) -> (String, Int) {
        return (genreMovie[row].name, genreMovie[row].id)
    }
    
    func setupViewController(completion : @escaping () -> Void) {
        service.fetchNameGenres { result in
            switch result {
            case .success( let listGenre):
                self.genreMovie = listGenre
                completion()
            case .failure:
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        
    }
}
