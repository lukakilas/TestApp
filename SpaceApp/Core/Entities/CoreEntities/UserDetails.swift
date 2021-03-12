//
//  UserDetails.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

class UserDetails {
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
    var notes: String?

    init(name: String?,
        company: String?,
        blog: String?,
        location: String?,
        email: String?,
        hireable: Bool?,
        bio: String?,
        twitter_username: String?,
        public_repos: Int?,
        public_gists: Int?,
        followers: Int?,
        following: Int?,
        created_at: String?,
        updated_at: String?,
        notes: String?) {

        self.name = name
        self.company = company
        self.blog = blog
        self.location = location
        self.email = email
        self.hireable = hireable
        self.bio = bio
        self.twitter_username = twitter_username
        self.public_repos = public_repos
        self.public_gists = public_gists
        self.followers = followers
        self.following = followers
        self.created_at = created_at
        self.updated_at = updated_at
        self.notes = notes
    }
}

