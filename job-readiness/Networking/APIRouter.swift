//
//  APIRouter.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case categories
    
    
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
        case .categories:
            return "sites/$SITE_ID/domain_discovery/search?q=$Q"
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
        
        let base = URL(string: API.baseURL.rawValue)!
        let baseAppend = base.appendingPathComponent(path).absoluteString.removingPercentEncoding
        let url = URL(string: baseAppend!)
        
        var urlRequest =  URLRequest(url: url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        // Note: not required for current demo but if required to add you can add them as follows
        
//        urlRequest.setValue(HTTPHeaderFieldValue.AcceptTenant.rawValue, forHTTPHeaderField: HTTPHeaderField.AcceptTenant.rawValue)
        
        // Parameters if added
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
