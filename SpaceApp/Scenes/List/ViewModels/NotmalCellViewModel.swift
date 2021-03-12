//
//  NotmalCellViewModel.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

struct NormalCellViewModel: UserListCellViewModel {
    var title: String
    var description: String
    var reuseId: String { return "NormalTableViewCell" }
    var imageData: Data?
    var imageDownloadUseCase: DownloadAvatarUseCase
}
