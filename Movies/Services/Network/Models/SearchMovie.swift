//
//  SearchMovie.swift
//  Movies
//
//  Created by Alex Bro on 29.12.2020.
//

import Foundation

struct Search: Decodable {
    let search: [SearchMovie]
    let totalResults: String
    let response: ResponseType

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

struct SearchMovie: Decodable {
    let title, year, imdbID: String
    let type: TypeEnum
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum TypeEnum: String, Decodable {
    case movie = "movie"
    case series = "series"
}

enum ResponseType: String, Decodable {
    case trueCase = "True"
    case falseCase = "False"
}
