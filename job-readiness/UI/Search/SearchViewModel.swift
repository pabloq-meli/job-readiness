//
//  SearchViewModel.swift
//  job-readiness
//
//  Created by Pablo Andres Quagliata Novoa on 28/9/21.
//

import Foundation
import Alamofire

class SearchViewModel {
    func getCategories(completion: @escaping (Error?) -> Void) {
        APIClient.shared.performRequest(route: APIRouter.categories(query: "celular iphone")) { (result: Result<Category, AFError>) in
            switch result {
            case .success(let success):
                print(success.category_id)
                completion(nil)

            case .failure(let failure):
                print(failure)
            }
        }
    }
}
