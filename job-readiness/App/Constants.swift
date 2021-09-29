//
//  Constants.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import UIKit

enum API: String {
    case baseURL = "https://api.mercadolibre.com/"
    case bestSellers = "highlights/$SITE_ID/category/$CATEGORY_ID"
}

extension UIColor {
    static let meliColor = UIColor(named: "meli-color")
}
