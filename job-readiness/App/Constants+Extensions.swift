//
//  Constants.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import UIKit

enum API {
    static let baseURL = "https://api.mercadolibre.com/"
    static let accessToken = "APP_USR-6148044839167051-093019-cb30852dd059caa96f35a4d896d539e3-242994307"
    static var products = "items?ids="
    static let site = "MLU"
}

extension UIColor {
    static let meli = UIColor(named: "meli-color")
}

extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .darkText
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .systemFont(ofSize: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
