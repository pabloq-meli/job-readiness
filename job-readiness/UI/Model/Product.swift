//
//  Product.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 29/9/21.
//

import Foundation


// MARK: Best sellers
struct BestSeller: Codable {
    let id: String
    let position: Int
    let type: String
    
}

struct BestSellers: Codable {
    let content: [BestSeller]
    let queryData: QueryData
    
    enum CodingKeys: String, CodingKey {
        case content
        case queryData = "query_data"
    }
}

struct QueryData: Codable {
    let highlight_type: String
    let criteria: String
    let id: String
}

// MARK: Products
struct Product: Codable {
    let code: Int
    let attributes: Attributes?
    
    enum CodingKeys: String, CodingKey {
        case code
        case attributes = "body"
    }
}

struct Attributes: Codable {
    let id: String
    let siteID, title: String?
    let categoryID: String?
    let price, basePrice: Int?
    let currencyID: String?
    let condition: String?
    let acceptsMercadopago: Bool?
    let pictures: [Picture]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case siteID = "site_id"
        case title
        case categoryID = "category_id"
        case price
        case basePrice = "base_price"
        case currencyID = "currency_id"
        case condition
        case acceptsMercadopago = "accepts_mercadopago"
        case pictures
    }
}

struct Picture: Codable {
    let id: String
    let url: String
    let secureURL: String

    enum CodingKeys: String, CodingKey {
        case id, url
        case secureURL = "secure_url"
    }
}
