//
//  LocalFetchUsersGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation
import CoreData

typealias LocalUsersGatewayHandler = (_ result: Result<[UserCoreDataEntity], Error>) -> Void

protocol LocalFetchUsersGateway {
    func fetchUsers(completion: @escaping LocalUsersGatewayHandler)
}

class LocalFetchUsersGatewayImplementation: LocalFetchUsersGateway {
    func fetchUsers(completion: @escaping LocalUsersGatewayHandler) {
        let request: NSFetchRequest<UserCoreDataEntity> = UserCoreDataEntity.fetchRequest()
        do {
            let dataBaseUsers = try PersistantManager.context.fetch(request)
            let users = dataBaseUsers.compactMap({$0})
            completion(.success(users))
        }
        catch {
            completion(.failure(LocalError(error: "Couldn't Load from database")))
        }
    }
}
