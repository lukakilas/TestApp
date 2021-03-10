//
//  ApiFetchUserDetailsGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

typealias FetchUserDetailsGatewayHandler = (_ result: Result<UserDetails, Error>) -> Void

protocol ApiFetchUserDetailsGateway {
    func fetchDetails(with userName: String, completion: @escaping FetchUserDetailsGatewayHandler)
}

class ApiFetchUserDetailsGatewayImpl: ApiFetchUserDetailsGateway {
    func fetchDetails(with userName: String, completion: @escaping FetchUserDetailsGatewayHandler) {
        let urlString = "\(Constants.baseUrl)/users/\(userName)"
        guard let url = URL(string: urlString) else { return }
        Service.fetchAndParse(from: url, modelType: UserDetails.self) { (result) in
            switch result {
            case .success(let userDetails):
                completion(.success(userDetails))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

