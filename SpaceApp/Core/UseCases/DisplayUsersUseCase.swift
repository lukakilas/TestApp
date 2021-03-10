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
                    self.saveUsersInDataBase(users: users)
                    completion(.success(users))
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
                completion(.success(users))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func saveUsersInDataBase(users: [User]) {
        DispatchQueue(label: "CoreDataSavingQueue").async {
            users.forEach { user in
                let request: NSFetchRequest<UserCoreDataEntity> = UserCoreDataEntity.fetchRequest()
                request.predicate = NSPredicate(format: "id = %i", user.id)
                do {
                    if let existingUser = try PersistantManager.context.fetch(request).first {
                        self.setValues(to: existingUser, of: user)
                    } else {
                        let context = PersistantManager.context
                        let newUser = UserCoreDataEntity(context: context)
                        self.setValues(to: newUser, of: user)
                    }
                }
                catch {
                    fatalError("***DisplayUsersUseCaseImplementation*** Catch")
                }
            }
        }
    }
    
    private func setValues(to coreDataUser: UserCoreDataEntity, of apiUser: User) {
        coreDataUser.login = apiUser.login
        coreDataUser.id = Int32(apiUser.id)
        coreDataUser.node_id = apiUser.node_id
        coreDataUser.site_admin = apiUser.site_admin
        coreDataUser.imageUrl = apiUser.avatar_url
    }
}
