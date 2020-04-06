//
//  NetworkServiceSeries.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 18/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

enum ResultNameGenresSeries {
    case success(serieList: [SerieGenre])
    case failure(error: ErrorSeries)
}

enum ResultGenreSerie {
    case success(listGenre: [Serie])
    case failure(error: ErrorSeries)
}

enum ResultSerieDescription {
    case success(serie: SerieDescription?)
    case failure(error: ErrorSeries)
}

enum ErrorSeries {
    case parseError(error: String)
}

class NetworkServiceSeries {
    func fetchSerieNameGenres(completion: @escaping( _ result: ResultNameGenresSeries) -> Void) {
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
                    completion(ResultNameGenresSeries.success(serieList: listGenre))
                } catch {
                    if let data = data {
                        let str = String(data: data, encoding: .utf8)
                        print("Parse Error3", str as Any, error)
                    } else {
                        print("Parse Error3", error)
                    }
                    completion(ResultNameGenresSeries.failure(error: ErrorSeries.parseError(error: "Erro no parse")))
                }
            }
            
        }.resume()
    }
    
    func fetchGenreSerie(id: Int, completion: @escaping( _ result: ResultGenreSerie) -> Void) {
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
                    completion(ResultGenreSerie.success(listGenre: serie))
                   } catch {
                      if let data = data {
                           let str = String(data: data, encoding: .utf8)
                           print("Parse Error3", str as Any, error)
                       } else {
                           print("Parse Error3", error)
                       }
                       completion(ResultGenreSerie.failure(error: ErrorSeries.parseError(error: "Erro no parse")))
                   }
               }
               
           }.resume()
           
       }
    func fetchSerieDescription(id: Int, completion: @escaping( _ result: ResultSerieDescription) -> Void) {
        var serie: SerieDescription?
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(id)?api_key=02a08061d7eead16928726e26cb3203c&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else {
                            return
                        }
                        
                        let descriptionSerie = try JSONDecoder().decode(SerieDescription.self, from: data)
                        serie = descriptionSerie
                        completion(ResultSerieDescription.success(serie: serie))
                    } catch {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(ResultSerieDescription.failure(error: ErrorSeries.parseError(error: "Erro no parse")))
                    }
                }
            }
        }.resume()
        
    }
}
