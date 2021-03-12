//
//  DisplayUserDetailsUseCase.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

typealias DisplayUsersDetailsUseCaseCompletionHandler = (_ result: Result<UserDetails, Error>) -> Void

protocol DisplayUserDetailsUseCase {
    func fetchDetails(with userName: String, completion: @escaping DisplayUsersDetailsUseCaseCompletionHandler)
}

class DisplayUserDetailsUseCaseImpl: DisplayUserDetailsUseCase {
    
    private let gateway: ApiFetchUserDetailsGateway
    
    init(gateway: ApiFetchUserDetailsGateway) {
        self.gateway = gateway
    }
    
    func fetchDetails(with userName: String, completion: @escaping DisplayUsersDetailsUseCaseCompletionHandler) {
        gateway.fetchDetails(with: userName) { (result) in
            switch result {
            case .success(let details):
                completion(.success(details.convertToCoreDetailsModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
