//
//  Router.swift
//  Movies
//
//  Created by Alex Bro on 11.01.2021.
//

import UIKit

protocol Router {
    func initialViewController()
    func toDetailView(view: UIViewController, model: MovieModel?)
    func toSearchView(view: UIViewController)
    func toProfileView(view: UIViewController)
    func exit(view: UIViewController)
}

final class RouterService: NSObject, Router {
    
    private var navigationController: UINavigationController?
    private var assembly: Assembly?
    private let transition = ProfileInTransition()
    
    init(navigationController: UINavigationController, assembly: Assembly?) {
        self.navigationController = navigationController
        self.assembly = assembly
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let listViewController = assembly?.makeModule(module: .listView, model: nil, router: self) else { return }
            navigationController.viewControllers = [listViewController]
        }
    }
    
    func toDetailView(view: UIViewController, model: MovieModel?) {
        guard let detailViewController = assembly?.makeModule(module: .detailView, model: model, router: nil) else { return }
        detailViewController.modalPresentationStyle = .overCurrentContext
        view.present(detailViewController, animated: true)
    }
    
    func toSearchView(view: UIViewController) {
        guard let searchViewController = assembly?.makeModule(module: .searchView, model: nil, router: self) else { return }
        searchViewController.modalPresentationStyle = .overCurrentContext
        view.present(searchViewController, animated: true)
    }
    
    func toProfileView(view: UIViewController) {
        guard let profileViewController = assembly?.makeModule(module: .profileView, model: nil, router: nil) else { return }
        profileViewController.modalPresentationStyle = .overCurrentContext
        profileViewController.transitioningDelegate = self
        view.present(profileViewController, animated: true)
    }
    
    func exit(view: UIViewController) {
        view.dismiss(animated: true)
    }
}

//MARK: - UIViewControllerTransitioningDelegate
extension RouterService: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
