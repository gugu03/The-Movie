//
//  MovieDescriptionViewModel.swift
//  Movies
//
//  Created by Luis Gustavo Oliveira Silva on 28/01/20.
//  Copyright © 2020 Luis Gustavo Oliveira Silva. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class MovieDescriptionViewModel {
    var service: TheMDBAPI = TheMDBAPIImpl()
    let id: Int
    var urlMovieDescriptionLink: URL?
    var descriptionFirebase: MovieDescription?
    var isFavorite: Bool = false
    
    init(id: Int) {
        self.id = id
    }
    
    func fetchMovieDescription(success: @escaping( _ movieDescription: MovieDescription) -> Void, failure: @escaping () -> Void) {
        service.fetchMovieDescription(id: id) { result in
            switch result {
            case .success(let movieDescription):
                if let description = movieDescription {
                    success(description)
                    self.descriptionFirebase = description
                    if let homePage = description.homepage {
                        self.setupHomePage(homePage: homePage)
                    }
                }
            case .failure:
                self.handleError()
            }
            failure()
        }
    }
    
    private func handleError() {
        
    }
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let newDate = dateFormatter.date(from: date) else { return date }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return  formatter.string(from: newDate)
    }
    
    func post() {
        guard let poster = descriptionFirebase?.posterPath else { return }
        let posterPath = "https://image.tmdb.org/t/p/original/\(poster)"
        let id = descriptionFirebase?.id
        let title = descriptionFirebase?.title
        let isFavorite = true
        
        let post: [String: AnyObject] = [ "posterPath": posterPath as AnyObject, "id": id as AnyObject, "isFavorite": isFavorite as AnyObject]
        
        let dbReference = Database.database().reference()
        dbReference.child("Movies").child(title ?? "").setValue(post)
        
    }
    
    func delete() {
        let title = descriptionFirebase?.title
        let dbReference = Database.database().reference()
        dbReference.child("Movies").child(title ?? "").removeValue()
    }
    
    func data(completion : @escaping () -> Void) {
        let title = descriptionFirebase?.title
        let dbReference = Database.database().reference()
        dbReference.child("Movies/\(title ?? "")/isFavorite").observe(.value) { (snapshot: DataSnapshot) in
            if let values = snapshot.value as? Bool {
                self.isFavorite = values
                completion()
            }
        }
    }
    
    func setupHomePage(homePage: String) {
        guard let url = URL(string: homePage ) else { return }
        urlMovieDescriptionLink = url
    }
}
