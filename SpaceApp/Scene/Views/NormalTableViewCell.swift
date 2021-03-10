//
//  NormalTableViewCell.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

class NormalTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCornersToImageView()
    }
    
    private func roundCornersToImageView() {
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView.clipsToBounds = true
    }
}

// MARK: - TableViewCell Protocol Conformance
extension NormalTableViewCell: TableViewCell {
    func configure(viewModel: TableViewCellViewModel) {
        guard let model = viewModel as? NormalCellViewModel else { return }
        nameLabel.text = model.title
        detailsLabel.text = model.description
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

