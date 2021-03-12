//
//  User.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

class User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }

    var login: String
    var id: Int
    var node_id: String
    var avatar_url: String
    var site_admin: Bool
    var imageData: Data?
    var notes: String?
    
    init(login: String,
         id: Int,
         node_id: String,
         avatar_url: String,
         site_admin: Bool,
         imageData: Data?,
         notes: String?) {
        
        self.login = login
        self.id = id
        self.node_id = node_id
        self.avatar_url = avatar_url
        self.site_admin = site_admin
        self.imageData = imageData
        self.notes = notes
    }
    
}
