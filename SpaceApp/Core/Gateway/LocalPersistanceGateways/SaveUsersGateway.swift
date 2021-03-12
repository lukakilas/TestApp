//
//  SaveUsersGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 13.03.21.
//

import Foundation
import CoreData

protocol SaveUsersGateway {
    func saveUsersInDataBase(_ users: [ApiUserEntity])
}

class SaveUsersGatewayImpl: SaveUsersGateway {
    
    func saveUsersInDataBase(_ users: [ApiUserEntity]) {
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
                    print("No Items in Core Data")
                }
            }
        }
    }
    
    private func setValues(to coreDataUser: UserCoreDataEntity, of apiUser: ApiUserEntity) {
        coreDataUser.login = apiUser.login
        coreDataUser.id = Int32(apiUser.id)
        coreDataUser.node_id = apiUser.node_id
        coreDataUser.site_admin = apiUser.site_admin
        coreDataUser.imageUrl = apiUser.avatar_url
    }
}
