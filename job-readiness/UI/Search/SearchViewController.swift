//
//  SearchViewController.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var resultsTableView: UITableView! {
        didSet {
            resultsTableView.delegate = self
            resultsTableView.dataSource = self
            resultsTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    // MARK: Properties
    private let cellIdentifier = String(describing: ProductResultTableViewCell.self)
    private let searchController = UISearchController()
    private let viewModel = SearchViewModel()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        searchController.searchBar.returnKeyType = .done
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

// MARK: SearchController Delegate
extension SearchViewController: UISearchBarDelegate {
    
}

// MARK: TableView Delegates
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        _ = resultsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductResultTableViewCell
        return UITableViewCell()
    }
    
    
}
