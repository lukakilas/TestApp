//
//  NormalTableViewCell.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

class NormalTableViewCell: UserListTableViewCell {
    override var reuseIdentifier: String? { "NormalTableViewCell" }
}

// MARK: - TableViewCell Protocol Conformance
extension NormalTableViewCell: TableViewCell {
    func configure(viewModel: TableViewCellViewModel) {
        guard let model = viewModel as? NormalCellViewModel else { return }
        titleLbl.text = model.title
        descriptionLbl.text = model.description
        if let imageData = model.imageData {
            self.iconImageView.image = UIImage(data: imageData) // Core Data Case
        } else {
            model.imageDownloadUseCase.download { [weak self] image in 
                DispatchQueue.main.async {
                    self?.iconImageView.image = image
                }
            }
        }
    }
}

