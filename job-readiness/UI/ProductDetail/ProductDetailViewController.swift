//
//  ProductDetailViewController.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import UIKit

class ProductDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var addToFavButton: UIButton! {
        didSet {
            addToFavButton.setTitle("Add to favorites", for: [])
        }
    }
    
    // MARK: Properties
    var viewModel: ProductDetailViewModel
    
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: Lifecycle
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavUI()
        setupProductData()
    }
    
    private func setupNavUI() {
        navigationController?.navigationBar.tintColor = .darkText
        switch viewModel.isFavorite {
        case true:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .done, target: self, action: #selector(updateFavorite(_:)))
        case false:
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .done, target: self, action: #selector(updateFavorite(_:)))
        }
    }
    
    private func setupProductData() {
        if let attributes = viewModel.product.attributes {
            productTitleLabel.text = attributes.title ?? "No title"
            productPriceLabel.text = "\(attributes.price ?? 0)"
        }
    }
    
    @objc private func updateFavorite(_ sender: UIBarButtonItem) {
        switch viewModel.isFavorite {
        case true:
            updateFavoriteStatusOfItem(to: false)
        case false:
            updateFavoriteStatusOfItem(to: true)
        }
    }
    
    private func updateFavoriteStatusOfItem(to isFavorite: Bool) {
        switch isFavorite {
        case true:
            viewModel.shouldSaveFavorite(true)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
        case false:
            viewModel.shouldSaveFavorite(false)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
        }
    }

}
