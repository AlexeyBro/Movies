//
//  SearchViewModel.swift
//  Movies
//
//  Created by Alex Bro on 29.12.2020.
//

import UIKit

protocol SearchViewModel {
    var searchMovie: [SearchMovie]? { get set }
    var numberOfRows: Int { get }
    func willDisplayCell(withIndex index: Int) -> SearchCellViewModel
    func searchMovie(withQuery query: String)
    func exit(view: UIViewController)
}

final class SearchViewModelImpl: SearchViewModel {
    
    weak var searchView: SearchView?
    private var networkService: Network?
    private var moviesStorage: MoviesStorage?
    private var router: Router?
    var searchMovie: [SearchMovie]? = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchView?.refreshView()
                self.searchView?.hideSearchInfo(isHidden: true)
            }
        }
    }
    
    var numberOfRows: Int {
        searchMovie?.count ?? 0
    }
    
    init(networkService: Network?, router: Router?, moviesStorage: MoviesStorage?) {
        self.router = router
        self.networkService = networkService
        self.moviesStorage = moviesStorage
        self.networkService?.searchDelegate = self
    }
    
    func willDisplayCell(withIndex index: Int) -> SearchCellViewModel {
        return SearchCellViewModelImpl(searchMovies: searchMovie?[index],
                                       moviesStorage: moviesStorage)
    }
    
    func searchMovie(withQuery query: String) {
        networkService?.searchMovie(withQuery: query)
    }
    
    func exit(view: UIViewController) {
        router?.exit(view: view)
        searchView?.refreshView()
    }
    
}

//MARK: - SearchMovieDelegate
extension SearchViewModelImpl: SearchMovieDelegate {
    func updateData(withModel model: [SearchMovie]?) {
        self.searchMovie = model
        if model == nil {
            DispatchQueue.main.async {
                self.searchView?.hideSearchInfo(isHidden: false)
                self.searchView?.errorSearchInfo()
            }
        }
    }
}
