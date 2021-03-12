//
//  NotyCellViewModel.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

struct NotyCellViewModel: UserListCellViewModel {
    var title: String
    var description: String
    var reuseId: String { return "NotyTableViewCell"}
    var imageData: Data?
    var imageDownloadUseCase: DownloadAvatarUseCase
}
