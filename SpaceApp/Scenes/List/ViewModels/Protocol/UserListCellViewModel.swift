//
//  UserListCellViewModel.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import Foundation

protocol UserListCellViewModel: TableViewCellViewModel {
    var title: String { get }
    var description: String { get }
    var reuseId: String { get }
    var imageData: Data? { get }
    var imageDownloadUseCase: DownloadAvatarUseCase { get }
}
