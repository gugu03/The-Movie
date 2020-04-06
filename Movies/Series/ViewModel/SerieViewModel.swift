//
//  SerieViewModel.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 12/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
class SerieViewModel {
    var genreSerie = [SerieGenre]()
    let service = NetworkServiceSeries()
    
    func numberOfSerie() -> Int {
        return genreSerie.count
    }
    
    func getSerie(at row: Int) -> (String, Int) {
        return (genreSerie[row].name, genreSerie[row].id)
    }
    
    func setupSeriesTableView(completion : @escaping () -> Void) {
        service.fetchSerieNameGenres { result in
            switch result {
            case .success( let serieList):
                self.genreSerie = serieList
                completion()
            case .failure:
                self.handleError()
            }
            completion()
        }
    }
    
    private func handleError() {
        
    }
}
