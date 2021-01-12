//
//  SearchViewController.swift
//  Movies
//
//  Created by Alex Bro on 24.12.2020.
//

import UIKit

protocol SearchView: AnyObject {
    func refreshView()
    func hideSearchInfo(isHidden: Bool)
    func errorSearchInfo()
}

final class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel
    var timer = Timer()
    let searchView = UISearchBar()
    let backButton = UIButton(image: UIImage(systemName: "arrow.backward"), tintColor: .white, backgroundColor: .darkBlue)
    let tableView = UITableView()
    let searchInfoView = SearchInfoView()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.darkBlue.withAlphaComponent(0.9)
        setupSearchBar()
        setupTableView()
        setupBackButton()
        setupConstraints()
        searchInfoView.settings(style: .initial)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backButton.layer.cornerRadius = backButton.frame.width / 2
    }
    
    private func setupBackButton() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
    
    @objc func goBack() {
        viewModel.exit(view: self)
    }
    
    private func setupSearchBar() {
        searchView.delegate = self
        searchView.showsCancelButton = true
        searchView.barTintColor = .white
        searchView.searchTextField.clearButtonMode = .never
        searchView.placeholder = "Search movie"
        searchView.backgroundImage = UIImage()
        searchView.searchTextField.backgroundColor = .white
    }
    
    private func setupTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerReusableCell(SearchTableViewCell.self)
    }
    
    private func setupConstraints() {
        [searchView, backButton, tableView, searchInfoView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: StyleGuide.Spaces.double),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            searchView.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: StyleGuide.Spaces.double),
            searchView.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -StyleGuide.Spaces.double),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: StyleGuide.Spaces.double),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            searchInfoView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 100),
            searchInfoView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            searchInfoView.widthAnchor.constraint(equalToConstant: 200),
            searchInfoView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(SearchTableViewCell.self, for: indexPath) else { return UITableViewCell() }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.configureView(withModel: viewModel.willDisplayCell(withIndex: indexPath.row))
        return cell
    }
}

//MARK: - SearchView
extension SearchViewController: SearchView {
    func refreshView() {
        tableView.reloadData()
    }
    
    func hideSearchInfo(isHidden: Bool) {
        searchInfoView.isHidden = isHidden
    }
    
    func errorSearchInfo() {
        searchInfoView.settings(style: .error)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            guard let query = self.searchView.text,
                  self.searchView.text?.isEmpty == false else { return }
            self.tableView.isHidden = false
            self.viewModel.searchMovie(withQuery: query)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchView.text = nil
        tableView.isHidden = true
        searchInfoView.isHidden = false
        searchInfoView.settings(style: .initial)
    }
}


