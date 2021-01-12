//
//  DetailViewController.swift
//  Movies
//
//  Created by Alex Bro on 22.12.2020.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var viewModel: DetailViewModel?
    private let detailView = DetailView()
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.darkBlue.withAlphaComponent(0.8)
        configureView()
        setupDetailView()
        setupConstraints()
        swipeSettings()
        viewModel?.setMovies()
        viewModel?.downloadBackdrop()
    }
    
    private func setupDetailView() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.frame = view.bounds
        view.addSubview(detailView)
    }
    
    private func configureView() {
        viewModel?.updateData = { [weak self] model in
            guard let self = self, let model = model else { return }
            self.detailView.runtimeLabel.text = model.runtime
            self.detailView.titleLabel.text = model.title
            self.detailView.genreLabel.text = model.genre
            self.detailView.directorsLabel.text = model.director
            self.detailView.starsLabel.text = model.actors
            self.detailView.plotTextView.text = model.plot
            self.detailView.starsView.makeRating(rating: Float(model.imdbRating))
        }
        
        viewModel?.updateBackdrop = { [weak self] backdropPath in
            guard let self = self, let backdropPath = backdropPath else { return }
            self.detailView.backdropImage.setImage(URLString: backdropPath)
        }
    }

    private func swipeSettings() {
        let swipe = UIPanGestureRecognizer(target: self, action: #selector(swiped))
        detailView.addGestureRecognizer(swipe)
        detailView.isUserInteractionEnabled = true
    }
    
    @objc func swiped() {
        dismiss(animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: StyleGuide.Spaces.double),
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -StyleGuide.Spaces.double),
            detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -StyleGuide.Spaces.double),
        ])
    }
}
