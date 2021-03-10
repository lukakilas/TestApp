//
//  UserDetails.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

struct UserDetails: Codable {
    var name: String
    var company: String
    var blog: String
    var location: String
    var email: String
    var hireable: Bool
    var bio: String
    var twitter_username: String
    var public_repos: String
    var public_gists: Int
    var followers: Int
    var following: Int
    var created_at: String
    var updated_at: String
}
