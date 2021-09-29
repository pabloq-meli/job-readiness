//
//  APIRouter.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case categories(query: String)
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .categories:
            return .get
            
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
//        case .categories:
//            return "posts/1"
        case .categories(let query):
            return "sites/\(API.site.rawValue)/domain_discovery/search?q=\(query)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .categories:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let encodedPath = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: API.baseURL.rawValue + encodedPath)!)
        
        /// HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        /// Set the Authorization header value using the access token.
        urlRequest.setValue("Bearer " + API.accessToken.rawValue, forHTTPHeaderField: "Authorization")
        
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
