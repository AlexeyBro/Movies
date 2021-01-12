//
//  Assembly.swift
//  Movies
//
//  Created by Alex Bro on 11.01.2021.
//

import UIKit

enum Modules {
    case listView
    case detailView
    case searchView
    case profileView
}

protocol Assembly {
    func makeModule(module: Modules, model: MovieModel?, router: Router?) -> UIViewController
}

final class AssemblyService: Assembly {
    
    private let movieStorage = MoviesStorageImpl()
    private let networkService = NetworkService()
    
    init() {
        networkService.movieStorage = movieStorage
    }
    
    func makeModule(module: Modules, model: MovieModel?, router: Router?) -> UIViewController {
        switch module {
        case .listView:
            return makeListView(router: router)
        case .detailView:
            return makeDetailView(model: model)
        case .searchView:
            return makeSearchView(router: router)
        case .profileView:
            return makeProfileView()
        }
    }
    
    private func makeListView(router: Router?) -> UIViewController {
        let listViewModel = ListViewModelImpl(networkService: networkService, router: router)
        let listViewController = ListViewController(viewModel: listViewModel)
        listViewModel.listView = listViewController
        return listViewController
    }
    
    private func makeDetailView(model: MovieModel?) -> UIViewController {
        let detailViewModel = DetailViewModelImpl(movieModel: model, networkService: networkService)
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        return detailViewController
    }
    
    private func makeSearchView(router: Router?) -> UIViewController {
        let searchViewModel = SearchViewModelImpl(networkService: networkService, router: router, moviesStorage: movieStorage)
        let searchViewController = SearchViewController(viewModel: searchViewModel)
        searchViewModel.searchView = searchViewController
        return searchViewController
    }
    
    private func makeProfileView() -> UIViewController {
        let profileViewController = ProfileViewController()
        return profileViewController
    }
}
