//
//  User.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

class ApiUserEntity: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let site_admin: Bool
    
    init(login: String,
        id: Int,
        node_id: String,
        avatar_url: String,
        site_admin: Bool,
        imageData: Data?) {
        
        self.login = login
        self.id = id
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.site_admin = site_admin
    }
}

extension ApiUserEntity {
    var convertToCoreUserModel: User {
        return User(login: login,
                             id: id,
                             node_id: node_id,
                             avatar_url: avatar_url,
                             site_admin: site_admin,
                             imageData: nil,
                             notes: nil)
    }
}
