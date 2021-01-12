//
//  DetailViewModel.swift
//  Movies
//
//  Created by Alex Bro on 27.12.2020.
//

import Foundation

protocol DetailViewModel {
    var updateData: ((MovieModel?) -> Void)? { get set }
    var updateBackdrop: ((String?) -> Void)? { get set }
    func setMovies()
    func downloadBackdrop()
}

final class DetailViewModelImpl: DetailViewModel {
    
    var updateData: ((MovieModel?) -> Void)?
    var updateBackdrop: ((String?) -> Void)?
    private var movieModel: MovieModel?
    private var backdropPath: String?
    private var networkService: Network?
    
    init(movieModel: MovieModel?, networkService: Network?) {
        self.movieModel = movieModel
        self.networkService = networkService
        self.networkService?.backdropDelegate = self
    }
    
    func setMovies() {
        updateData?(movieModel)
    }

    func downloadBackdrop() {
        networkService?.downloadBackdrop(withId: movieModel?.imdbID ?? "")
    }
}

//MARK: - BackdropDelegate
extension DetailViewModelImpl: BackdropDelegate {
    func updateBackdrop(backdropPath: String?) {
        self.backdropPath = backdropPath
        updateBackdrop?(backdropPath)
    }
}

