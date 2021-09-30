//
//  APIClient.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

class APIClient {

    /// singleton
    static let shared = APIClient()
    
    private init() { }
    
    /// request
    func performRequest<T:Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (AFResult<T>) -> Void) -> DataRequest {
        AF.request(route)
            .responseDecodable (decoder: decoder){ (response: AFDataResponse<T>) in
                completion(response.result)
        }
    }
}
