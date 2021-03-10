//
//  UserCoreDataEntity+CoreDataProperties.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//
//

import Foundation
import CoreData
import UIKit


extension UserCoreDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreDataEntity> {
        return NSFetchRequest<UserCoreDataEntity>(entityName: "UserCoreDataEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var login: String?
    @NSManaged public var site_admin: Bool
    @NSManaged public var node_id: String?
    @NSManaged public var image: Data? 
    @NSManaged public var imageUrl: String?

}

extension UserCoreDataEntity : Identifiable {
    var convertToUserModel: User? {
        guard let login = login,
              let node_id = node_id else { return nil }
        let user = User(login: login,
                        id: Int(id),
                        node_id: node_id,
                        avatar_url: imageUrl ?? "",
                        site_admin: site_admin,
                        imageData: image)
        return user
    }
}
