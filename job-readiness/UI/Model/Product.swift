//
//  Product.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 29/9/21.
//

import Foundation

struct Product: Codable {
    let id: String
    let position: Int
    let type: String
    
}

struct Products: Codable {
    let content: [Product]
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
