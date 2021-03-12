//
//  UserDetails.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

struct ApiUserDetailsEntity: Codable {
    var name: String?
    var company: String?
    var blog: String?
    var location: String?
    var email: String?
    var hireable: Bool?
    var bio: String?
    var twitter_username: String?
    var public_repos: Int?
    var public_gists: Int?
    var followers: Int?
    var following: Int?
    var created_at: String?
    var updated_at: String?
}

extension ApiUserDetailsEntity {
    var convertToCoreDetailsModel: UserDetails {
        return UserDetails(name: name,
                           company: company,
                           blog: blog,
                           location: location,
                           email: email,
                           hireable: hireable,
                           bio: bio,
                           twitter_username: twitter_username,
                           public_repos: public_repos,
                           public_gists: public_gists,
                           followers: followers,
                           following: following,
                           created_at: created_at,
                           updated_at: updated_at,
                           notes: nil)
    }
}


