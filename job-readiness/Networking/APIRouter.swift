//
//  APIRouter.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    // MARK: Routes
    case categories(query: String)
    case bestSellers(categoryId: String)
    case products(items: [String])
    
    // MARK: HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .bestSellers, .categories, .products:
            return .get
            
        }
    }
    
    // MARK: Path
    private var path: String {
        switch self {
        case .bestSellers(let id):
            return "highlights/\(API.site)/category/\(id)"
        case .categories(let query):
            return "sites/\(API.site)/domain_discovery/search?q=\(query)"
        case .products(let items):
            var itemsPath = API.products
            items.forEach { itemsPath += ($0 + ",")}
            return itemsPath
        }
    }
    
    // MARK: Parameters
    private var parameters: Parameters? {
        switch self {
        case .bestSellers, .categories, .products:
            return nil
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: API.baseURL + encodedPath)!)
        
        /// HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + API.accessToken, forHTTPHeaderField: "Authorization")
        
        /// Parameters if added
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        
        return urlRequest
    }
}
