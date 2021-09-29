//
//  ProductResultTableViewCell.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import UIKit

class ProductResultTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var glassImageView: UIImageView!
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var arrowImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setup(viewModel: ProductResultCellViewModel) {
        // TODO
    }
    
}
