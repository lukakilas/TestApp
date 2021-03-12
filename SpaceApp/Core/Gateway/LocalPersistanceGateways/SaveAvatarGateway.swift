//
//  SaveAvatarGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 13.03.21.
//

import CoreData

protocol SaveAvatarGateway {
    func saveImageDataToDisk(_ imageData: Data, for imageUrlString: String)
}

class SaveAvatarGatewayImpl: SaveAvatarGateway {
    func saveImageDataToDisk(_ imageData: Data, for imageUrlString: String) {
        let userFetchRequest: NSFetchRequest<UserCoreDataEntity> = UserCoreDataEntity.fetchRequest()
        do
        {
            let result = try PersistantManager.context.fetch(userFetchRequest)
            let model = result.first(where: {$0.imageUrl == imageUrlString })
            model?.setValue(imageData, forKey: "image")
            PersistantManager.saveContext()
        }
        catch {
            print("error")
        }
    }
}
