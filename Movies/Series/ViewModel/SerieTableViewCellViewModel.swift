//
//  SerieTableViewCellViewModel.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 12/02/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
class SerieTableViewCellViewModel {
    let service = NetworkServiceSeries()
    var id = 0
    var genreSeries = [Serie]()
    
    func numberOfSeries() -> Int {
        return genreSeries.count
    }
    
    func getSerie(at row: Int) -> URL? {
     return genreSeries[row].posterURL
    }
    
    func setupSerieTableViewCell(completion : @escaping () -> Void) {
        service.fetchGenreSerie(id: id) { result in
            switch result {
            case .success(let listGenre):
                self.genreSeries = listGenre
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
