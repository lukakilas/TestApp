//
//  ApiFetchUsersGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

typealias FetchUsersGatewayHandler = (_ result: Result<[ApiUserEntity], Error>) -> Void

protocol ApiFetchUsersGateway {
    func fetchUsers(completion: @escaping FetchUsersGatewayHandler)
}

class ApiFetchUsersGatewayImplementation: ApiFetchUsersGateway {
    
    private let saveUsersGateway: SaveUsersGateway?
    
    init(saveUsersGateway: SaveUsersGateway) {
        self.saveUsersGateway = saveUsersGateway
    }
    
    func fetchUsers(completion: @escaping FetchUsersGatewayHandler) {
        guard let url = URL(string: Constants.baseUrl) else { return }
        Service.fetchAndParse(from: url, modelType: [ApiUserEntity].self) { (result) in
            switch result {
            case .success(let users):
                self.saveUsersGateway?.saveUsersInDataBase(users)
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
