//
//  SearchViewModel.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

class SearchViewModel {
    
    var bestSellers: [Product] = []
    
    func getCategories(completion: @escaping (Error?) -> Void) {
        APIClient.shared.performRequest(route: APIRouter.categories(query: "celular iphone")) { (result: Result<[Category], AFError>) in
            switch result {
            case .success(let success):
                print(success.first?.category_id)
                self.getBestSellersByCategory(categoryId: success.first?.category_id ?? "") { error in
                    guard error != nil else {
                        completion(nil)
                        return
                    }
                    
                    completion(error)
                }

            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getBestSellersByCategory(categoryId: String, completion: @escaping (Error?) -> Void) {
        APIClient.shared.performRequest(route: APIRouter.bestSellers(categoryId: categoryId)) { (result: Result<Products, AFError>) in
            switch result {
            case .success(let success):
                self.bestSellers = success.content
                print(self.bestSellers)
                completion(nil)
            case .failure(let failure):
                print(failure)
                completion(failure)
            }
        }
    }
}
