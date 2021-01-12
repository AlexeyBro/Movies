//
//  Constants.swift
//  Movies
//
//  Created by Alex Bro on 07.01.2021.
//

import Foundation

//MARK: - www.omdbapi.com
enum OmdbAPI {
    static let host = "https://www.omdbapi.com/"
    static let info = "?i="
    static let search = "?s="
    static let plot = "&plot=full"
    static let apiKey = "&apikey=9cd77fc8"
}

//MARK: - api.themoviedb.org
enum EdbAPI {
    static let host = "https://api.themoviedb.org/"
    static let body = "3/movie/"
    static let language = "&language=en-US"
    static let apiKey = "?api_key=78f0a7746725815dee12cb22071cc027"
}

//MARK: - image.tmdb.org
enum TmdbAPI {
    static let host = "https://image.tmdb.org/"
    static let body = "t/p/w500"
}
