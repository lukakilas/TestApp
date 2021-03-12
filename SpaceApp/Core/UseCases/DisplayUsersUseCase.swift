//
//  DisplayUsersUseCase.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation
import CoreData

typealias DisplayUsersUseCaseCompletionHandler = (_ result: Result<[User], Error>) -> Void

protocol DisplayUsersUseCase {
    func fetchUsersFromApi(completion: @escaping DisplayUsersUseCaseCompletionHandler)
    func fetchUsersFromDataBase(completion: @escaping DisplayUsersUseCaseCompletionHandler)
}

class DisplayUsersUseCaseImplementation: DisplayUsersUseCase {
    
    private let gateway: FetchUsersGateway
    
    init(gateway: FetchUsersGateway) {
        self.gateway = gateway
    }
    
    func fetchUsersFromApi(completion: @escaping DisplayUsersUseCaseCompletionHandler) {
        gateway.apiFetchUsersGateway.fetchUsers { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    completion(.success(users.map({$0.convertToCoreUserModel})))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func fetchUsersFromDataBase(completion: @escaping DisplayUsersUseCaseCompletionHandler) {
        gateway.localFetchUsersGateway.fetchUsers { (result) in
            switch result {
            case .success(let users):
                completion(.success(users.compactMap({$0.convertToUserModel})))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
