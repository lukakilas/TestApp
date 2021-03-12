//
//  SaveUserNotesGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation
import CoreData

protocol SaveUserNotesGateway {
    func saveNotes(_ notes: String, for id: Int, completion: @escaping (Bool) -> Void)
}

class SaveUserNotesGatewayImpl: SaveUserNotesGateway {
    func saveNotes(_ notes: String, for id: Int, completion: @escaping (Bool) -> Void) {
        let request: NSFetchRequest<UserCoreDataEntity> = UserCoreDataEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)
        do {
            if let user = try PersistantManager.context.fetch(request).first {
                user.notes = notes
                PersistantManager.saveContext()
                completion(true)
            }
        }
        catch {
            completion(false)
        }
    }
}
