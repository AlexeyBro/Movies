//
//  NetworkService.swift
//  Movies
//
//  Created by Alex Bro on 24.12.2020.
//

import Foundation

protocol Network {
    var movieModeldelegate: MovieModelDelegate? { get set }
    var searchDelegate: SearchMovieDelegate? { get set }
    var backdropDelegate: BackdropDelegate? { get set }
    func fetchMovies()
    func searchMovie(withQuery query: String)
    func downloadBackdrop(withId id: String)
}

final class NetworkService: Network {

    var movieStorage: MoviesStorage?
    weak var movieModeldelegate: MovieModelDelegate?
    weak var searchDelegate: SearchMovieDelegate?
    weak var backdropDelegate: BackdropDelegate?
    private var movies: [MovieModel?] = []
    private var backDrops: [Backdrop?] = []
    private let downloadGroup = DispatchGroup()
    private var counter = 0
    
    private func request(string: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: string) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let response = response as? HTTPURLResponse
            if let error = error {
                completion(.failure(error))
            }
            if response?.statusCode == 200, let data = data {
                completion(.success(data))
            }
        }.resume()
    }
    
    private func decode<T: Decodable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let value = try decoder.decode(type, from: data)
            return value
        } catch let jsonError {
            print(jsonError.localizedDescription)
        }
        return nil
    }
    
    func fetchMovies() {
        for index in counter..<counter + 10 {
            guard counter < movieStorage?.movies.count ?? 0 else { break }
            downloadGroup.enter()
            guard let id = movieStorage?.movies[index] else { return }
            downloadMovies(withId: id, group: downloadGroup)
            counter += 1
        }
        
        downloadGroup.notify(queue: .main) {
            self.movieModeldelegate?.updateData(withModel: self.movies)
        }
    }
    
    private func downloadMovies(withId id: String, group: DispatchGroup) {
        let urlString = OmdbAPI.host + OmdbAPI.info + id + OmdbAPI.plot + OmdbAPI.apiKey
        request(string: urlString) { result in
            defer {
                group.leave()
            }
            switch result {
            case .success(let data):
                let model = self.decode(type: MovieModel.self, data: data)
                model.map { self.movies.append($0) }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadBackdrop(withId id: String) {
        let urlString = EdbAPI.host + EdbAPI.body + id + EdbAPI.apiKey + EdbAPI.language
        request(string: urlString) { result in
            switch result {
            case .success(let data):
                guard let model = self.decode(type: Backdrop.self, data: data) else { return }
                let backdropPath = TmdbAPI.host + TmdbAPI.body + model.backdropPath
                self.backdropDelegate?.updateBackdrop(backdropPath: backdropPath)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchMovie(withQuery query: String) {
        let urlString = OmdbAPI.host + OmdbAPI.search + query + OmdbAPI.apiKey
        request(string: urlString) { result in
            switch result {
            case .success(let data):
                let model = self.decode(type: Search.self, data: data)
                self.searchDelegate?.updateData(withModel: model?.search)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
