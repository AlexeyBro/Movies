//
//  MoviesStorege.swift
//  Movies
//
//  Created by Alex Bro on 24.12.2020.
//

import Foundation

protocol MoviesStorage: AnyObject {
    var movies: [String] { get set }
    func checkItems(forId id: String) -> Bool
    func addItem(withId id: String)
}

final class MoviesStorageImpl: MoviesStorage {
    
    var movies: [String] {
        get {
            return UserDefaults.standard.array(forKey: "moviesArray") as? [String] ?? []
        }
        set {
            return UserDefaults.standard.setValue(newValue, forKey: "moviesArray")
        }
    }
    
    init() {
        if movies.isEmpty {
            UserDefaults.standard.setValue(moviesArray, forKey: "moviesArray")
        }
    }
    
    func checkItems(forId id: String) -> Bool {
        for movie in movies {
            if movie == id {
                return true
            }
        }
        return false
    }
    
    func addItem(withId id: String) {
        moviesArray.insert(id, at: 0)
        movies = moviesArray
    }
    
    private var moviesArray = ["tt0120689", //"The Green Mile"
                               "tt0109830", //"Forrest Gump"
                               "tt0111161", //"The Shawshank Redemption"
                               "tt0816692", //"Interstellar"
                               "tt0108052", //"Schindler's List"
                               "tt7286456", //"Joker"
                               "tt0088763", //"Back to the Future"
                               "tt0110357", //"The Lion King"
                               "tt0208092", //"Snatch"
                               "tt0110912", //"Pulp Fiction"
                               "tt0120735", //"Lock, Stock and Two Smoking Barrels"
                               "tt1375666", //"Inception"
                               "tt1130884", //"Shutter Island"
                               "tt8367814", //"The Gentlemen"
                               "tt0110413", //"Léon: The Professional"
                               "tt0137523", //"Fight Club"
                               "tt0482571", //"The Prestige"
                               "tt0264464", //"Catch Me If You Can"
                               "tt0133093", //"The Matrix"
                               "tt0268978", //"A Beautiful Mind"
                               "tt1853728", //"Django Unchained"
                               "tt0468569", //"The Dark Knight"
                               "tt0172495", //"Gladiator"
                               "tt0099785", //"Home Alone"
                               "tt0102926", //"The Silence of the Lambs"
                               "tt0120382", //"The Truman Show"
                               "tt0993846", //"The Wolf of Wall Street"
                               "tt0162222", //"Cast Away"
                               "tt0119174", //"The Game"
                               "tt0112573"] //"Braveheart"
}
