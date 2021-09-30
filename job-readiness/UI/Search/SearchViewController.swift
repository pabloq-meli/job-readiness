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
        setupSearchController()
        viewModel.getCategories { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.resultsTableView.reloadData()
                }
            }
        }
    }
    
    private func setupSearchController() {
        searchController.searchBar.returnKeyType = .done
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.tintColor = .darkText
    }
    
    private func setupNavigationController() {
        self.navigationItem.title = "Your Title"
        
        navigationController?.navigationBar.isTranslucent = false
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .meli
        appearance.titleTextAttributes = [.foregroundColor: UIColor.darkText]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
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
        return viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = resultsTableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProductResultTableViewCell
        cell.selectionStyle = .none
        
        if !viewModel.bestSellers.isEmpty && !viewModel.products.isEmpty {
            cell.setup(viewModel: ProductResultCellViewModel(product: viewModel.products[indexPath.row]))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.products[indexPath.row]
        if let attributes = product.attributes {
            if UserDefaults.standard.string(forKey: attributes.id) != nil {
                navigationController?.pushViewController(ProductDetailViewController(viewModel: ProductDetailViewModel(isFavorite: true, product: product)), animated: true)
            } else {
                navigationController?.pushViewController(ProductDetailViewController(viewModel: ProductDetailViewModel(isFavorite: false, product: product)), animated: true)
            }
            
        }
    }
}
