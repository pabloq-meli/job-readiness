//
//  ProductDetailViewModel.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation

class ProductDetailViewModel {
    var isFavorite: Bool
    let product: Product
    
    init(isFavorite: Bool, product: Product) {
        self.isFavorite = isFavorite
        self.product = product
    }
    
    func shouldSaveFavorite(_ bool: Bool) {
        guard let attributes = product.attributes else { return }
        switch bool {
        case true:
            isFavorite = true
            UserDefaults.standard.set(attributes.id, forKey: attributes.id)
        case false:
            isFavorite = false
            UserDefaults.standard.removeObject(forKey: attributes.id)
        }
    }
    
}
