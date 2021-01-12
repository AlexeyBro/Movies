//
//  CollectionCellViewModel.swift
//  Movies
//
//  Created by Alex Bro on 25.12.2020.
//

import UIKit

protocol CollectionCellViewModel {
    var title: String? { get }
    var genre: String? { get }
    var directors: String? { get }
    var year: String? { get }
    var runtime: String? { get }
    var rating: String? { get }
    var poster: String? { get }
}

final class CollectionCellViewModelImpl: CollectionCellViewModel {
    
    var title: String? { moviesModel?.title }
    var genre: String? { moviesModel?.genre }
    var directors: String? { moviesModel?.director }
    var year: String? { moviesModel?.year }
    var runtime: String? { moviesModel?.runtime }
    var rating: String? { moviesModel?.imdbRating }
    var poster: String? { moviesModel?.poster}
    var moviesModel: MovieModel?
    
    init(moviesModel: MovieModel?) {
        self.moviesModel = moviesModel
    }
}

