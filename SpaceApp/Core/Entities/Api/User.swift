//
//  User.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

struct User: Codable {
    let login: String
    let id: Int
    let node_id: String
    let avatar_url: String
    let site_admin: Bool
    let imageData: Data?
}

extension User {
    var getNormalCellModel: NormalCellViewModel {
        let avatarDownloadUseCase = DownloadAvatarUseCaseImpl(urlString: avatar_url)
        return NormalCellViewModel(title: login,
                            description: node_id,
                            imageData: imageData,
                            imageDownloadUseCase: avatarDownloadUseCase)
    }
}
