//
//  ListViewController.swift
//  Movies
//
//  Created by Alex Bro on 20.12.2020.
//

import UIKit

protocol ListView: AnyObject {
    func refreshView()
}

final class ListViewController: UIViewController {
    
    let viewModel: ListViewModel
    private let refreshControl = UIRefreshControl()
    private var isLoading = true
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        return collectionView
    }()
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        setupTitle()
        setupBarButtons()
        setupCollectionView()
        viewModel.loadItems()
    }
    
    private func setupTitle() {
        let title = UILabel(text: "Movie Browser", textColor: .darkBlue, font: .defaultBold22)
        self.navigationItem.titleView = title
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .beige
        collectionView.alwaysBounceVertical = true
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        collectionView.registerReusableCell(CollectionViewCell.self)
    }
    
    @objc func didPullToRefresh() {
        viewModel.loadItems()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    private func setupBarButtons() {
        let leftButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftButton.setImage(named: "person.crop.circle", style: .navBar)
        rightButton.setImage(named: "magnifyingglass", style: .navBar)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
    }
    
    @objc func leftButtonAction() {
        viewModel.showProfileView(view: self)
    }
    
    @objc func rightButtonAction() {
        viewModel.showSearchView(view: self)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(CollectionViewCell.self, for: indexPath) else { fatalError() }
        cell.configureView(withModel: viewModel.willDisplayCell(withIndex: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = viewModel.movieModel[indexPath.row] else { return }
        viewModel.showDetailView(view: self, model: model)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if isLoading {
                loadMore()
            }
        }
    }
    
    private func loadMore() {
        isLoading = false
        viewModel.loadItems()
        isLoading = true
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize() }
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let width = collectionView.frame.width / 2
        let height = collectionView.frame.width * 0.7
        return CGSize(width: width, height: height)
    }
}

//MARK: ListView
extension ListViewController: ListView {
    func refreshView() {
        collectionView.reloadData()
    }
}
