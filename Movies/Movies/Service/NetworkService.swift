//
//  NetworkService.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 13/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

class NetworkService {
    func fetchGenreMovies(id: Int, completion: @escaping( _ movies: [Movie]?) -> Void) {
        var movie = [Movie]()
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=02a08061d7eead16928726e26cb3203c&language=pt&page=1&with_genres=\(id)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    let list = try JSONDecoder().decode(ListMovie.self, from: data)
                    movie = list.results
                    completion(movie)
                } catch {
                    if let data = data {
                        let str = String(data: data, encoding: .utf8)
                        print("Parse Error3", str as Any, error)
                    } else {
                        print("Parse Error3", error)
                    }
                    completion(nil)
                }
            }
            
        }.resume()
        
    }
    
    func fetchNameGenres(completion: @escaping( _ name: [Genre]?) -> Void) {
        var listGenre = [Genre]()
        guard let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=02a08061d7eead16928726e26cb3203c&page=1&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    let list = try JSONDecoder().decode(GenreList.self, from: data)
                    listGenre = list.genres
                    completion(listGenre)
                } catch {
                    print("Parse Error2", error)
                    completion(nil)
                }
            }
            
        }.resume()
    }
    
    func fetchMovieDescription(id: Int, completion: @escaping( _ movieDescription: MovieDescription?) -> Void) {
        var movie: MovieDescription?
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=02a08061d7eead16928726e26cb3203c&language=pt-BR") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if error == nil {
                do {
                    guard let data = data else {
                        return
                    }
                    
                    let descriptionMovie = try JSONDecoder().decode(MovieDescription.self, from: data)
                    movie = descriptionMovie
                    completion(movie)
                } catch {
                    print("Parse Error1", error)
                    completion(nil)
                }
            }
            
        }.resume()
        
    }
}
