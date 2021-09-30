//
//  ProductImageCollectionViewCell.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 30/9/21.
//

import UIKit
import Kingfisher

class ProductImageCollectionViewCell: UICollectionViewCell {

    // MARK: Outlets
    @IBOutlet private weak var productImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Setup
    func setup(viewModel: ProductImageCollectionViewModel) {
        if let picture = viewModel.picture,
           let url = URL(string: picture.secureURL) {
            productImageView.kf.setImage(with: url)
        }
    }
}
