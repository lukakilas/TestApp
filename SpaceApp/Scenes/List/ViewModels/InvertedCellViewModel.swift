//
//  InvertedCellViewModel.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

struct InvertedCellViewModel: UserListCellViewModel {
    var title: String
    var description: String
    var reuseId: String { return "InvertedTableViewCell"}
    var imageData: Data?
    var imageDownloadUseCase: DownloadAvatarUseCase
}
