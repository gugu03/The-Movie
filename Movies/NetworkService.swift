//
//  NetworkService.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 13/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation

class NetworkService{
    func fetchMoviePopular() -> [Movie] {
        var movie = [Movie]()
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=02a08061d7eead16928726e26cb3203c&page=1&language=pt-BR")
        URLSession.shared.dataTask(with: url!) { (data, response , error) in
            
            if error == nil{
                do{
                    let list =  try JSONDecoder().decode(ListMovie.self, from: data!)
                    movie =  list.results
                } catch {
                    print("Parse Error")
                }
            }
            
        }.resume()
        return movie
    }
}
