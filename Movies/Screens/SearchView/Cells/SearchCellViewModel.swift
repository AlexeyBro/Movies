//
//  SearchCellViewModel.swift
//  Movies
//
//  Created by Alex Bro on 29.12.2020.
//

import Foundation

protocol SearchCellViewModel {
    var title: String? { get }
    var year: String? { get }
    var poster: String? { get }
    var id: String? { get }
    func checkItems(forId id: String) -> Bool?
    func addItem(withId id: String)
}

final class SearchCellViewModelImpl: SearchCellViewModel {
    
    var title: String? { searchMovies?.title }
    var year: String? { searchMovies?.year }
    var poster: String? { searchMovies?.poster}
    var id: String? { searchMovies?.imdbID }
    private var searchMovies: SearchMovie?
    private var moviesStorage: MoviesStorage?
    
    init(searchMovies: SearchMovie?, moviesStorage: MoviesStorage?) {
        self.searchMovies = searchMovies
        self.moviesStorage = moviesStorage
    }
    
    func checkItems(forId id: String) -> Bool? {
        moviesStorage?.checkItems(forId: id)
    }
    
    func addItem(withId id: String) {
        moviesStorage?.addItem(withId: id)
    }
}
