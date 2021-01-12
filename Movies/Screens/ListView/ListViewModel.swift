//
//  ListViewModel.swift
//  Movies
//
//  Created by Alex Bro on 24.12.2020.
//

import UIKit

protocol ListViewModel {
    var movieModel: [MovieModel?] { get set }
    var backDrop: [Backdrop?] { get set }
    var numberOfRows: Int { get }
    func loadItems()
    func willDisplayCell(withIndex index: Int) -> CollectionCellViewModel
    func downloadBackdrop(withId id: String)
    func showDetailView(view: UIViewController, model: MovieModel?)
    func showProfileView(view: UIViewController)
    func showSearchView(view: UIViewController)
}

final class ListViewModelImpl: ListViewModel {
    
    weak var listView: ListView?
    private var networkService: Network?
    private var router: Router?
    var numberOfRows: Int { movieModel.count }
    var backDrop: [Backdrop?] = []
    var movieModel: [MovieModel?] = [] {
        didSet {
            DispatchQueue.main.async {
                self.listView?.refreshView()
            }
        }
    }
    
    init(networkService: Network?, router: Router?) {
        self.networkService = networkService
        self.router = router
        self.networkService?.movieModeldelegate = self
    }
    
    func loadItems() {
        networkService?.fetchMovies()
    }
    
    func downloadBackdrop(withId id: String) {
        networkService?.downloadBackdrop(withId: id)
    }
    
    func willDisplayCell(withIndex index: Int) -> CollectionCellViewModel {
        return CollectionCellViewModelImpl(moviesModel: movieModel[index])
    }
    
    func showDetailView(view: UIViewController, model: MovieModel?) {
        router?.toDetailView(view: view, model: model)
    }
    
    func showProfileView(view: UIViewController) {
        router?.toProfileView(view: view)
    }
    
    func showSearchView(view: UIViewController) {
        router?.toSearchView(view: view)
    }
}

//MARK: - MovieModelDelegate
extension ListViewModelImpl: MovieModelDelegate {
    func updateData(withModel model: [MovieModel?]) {
        self.movieModel = model
    }
}


