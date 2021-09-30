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
    @IBOutlet private weak var productImagesCollectionView: UICollectionView! {
        didSet {
            productImagesCollectionView.delegate = self
            productImagesCollectionView.dataSource = self
            productImagesCollectionView.register(UINib(nibName: String(describing: ProductImageCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: ProductImageCollectionViewCell.self))
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: 140, height: 210)
            productImagesCollectionView.collectionViewLayout = flowLayout
        }
    }
    
    @IBOutlet private weak var productPriceLabel: UILabel!
    @IBOutlet private weak var mercadoPagoImageView: UIImageView! {
        didSet {
            mercadoPagoImageView.isHidden = true
        }
    }
    
    // MARK: Properties
    var viewModel: ProductDetailViewModel
    
    // MARK: Lifecycle
    init(viewModel: ProductDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
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
        if let attributes = viewModel.product.attributes,
           let price = attributes.price {
            productTitleLabel.text = attributes.title ?? "No title"
            
            switch attributes.currencyID {
            case "USD":
                productPriceLabel.attributedText = attributeString(currency: "USD", price: "\(price)")
            default:
                productPriceLabel.attributedText = attributeString(currency: "UYU", price: "\(price)")
            }
            
            if let acceptsMercadoPago = attributes.acceptsMercadopago {
                switch acceptsMercadoPago {
                case true: mercadoPagoImageView.isHidden = false
                case false: mercadoPagoImageView.isHidden = true
                    
                }
            }
        }
    }
    
    private func attributeString(currency: String, price: String) -> NSAttributedString {
        let boldText = currency
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        let normalText = ": \(price)"
        let normalString = NSMutableAttributedString(string:normalText)
        attributedString.append(normalString)
        return attributedString
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

// MARK: UICollectionViewDelegate
extension ProductDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.product.attributes?.pictures?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productImagesCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ProductImageCollectionViewCell.self), for: indexPath) as! ProductImageCollectionViewCell
        cell.setup(viewModel: ProductImageCollectionViewModel(picture: viewModel.product.attributes?.pictures?[indexPath.row]))
        return cell
    }
}
