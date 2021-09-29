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
//    case bsaeURL = "https://jsonplaceholder.typicode.com/"
    case bestSellers = "highlights/$SITE_ID/category/$CATEGORY_ID"
    case accessToken = "APP_USR-6148044839167051-092820-f0b372319bfd4c743a91811aaf477175-242994307"
    case site = "MLU"
}

extension UIColor {
    static let meliColor = UIColor(named: "meli-color")
}
