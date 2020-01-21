//
//  NetworkServiceSeries.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
class NetworkServiceSeries {
    func fetchSerieNameGenres(completion: @escaping( _ serieGenre: [SerieGenre]?) -> Void) {
        var listGenre = [SerieGenre]()
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/tv/list?api_key=02a08061d7eead16928726e26cb3203c&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    let list = try JSONDecoder().decode(SeriesGenreList.self, from: data)
                    listGenre = list.genres
                    completion(listGenre)
                } catch {
                    print("Parse Error")
                    completion(nil)
                }
            }
            
        }.resume()
    }
    
    func fetchGenreSerie(id: Int, completion: @escaping( _ serie: [Serie]?) -> Void) {
           var serie = [Serie]()
           guard let url = URL(string: "https://api.themoviedb.org/3/discover/tv?api_key=02a08061d7eead16928726e26cb3203c&language=pt-BR&sort_by=popularity.desc&page=1&with_genres=\(id)&include_null_first_air_dates=false") else {
               return
           }
           URLSession.shared.dataTask(with: url) { data, _, error in
               
               if error == nil {
                   do {
                       guard let data = data else {
                           return
                       }
                       let list = try JSONDecoder().decode(ListSerie.self, from: data)
                       serie = list.results
                       completion(serie)
                   } catch {
                       print("Parse Error")
                       completion(nil)
                   }
               }
               
           }.resume()
           
       }
       
}
