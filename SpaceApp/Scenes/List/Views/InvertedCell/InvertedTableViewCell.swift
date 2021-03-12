//
//  InvertedTableViewCell.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import UIKit

class InvertedTableViewCell: UserListTableViewCell {
    override var reuseIdentifier: String? { return "InvertedTableViewCell" }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupColor()
    }
    
    private func setupColor() {
        self.iconContainerView.backgroundColor = .lightGray
    }
    
}

// MARK: - TableViewCell Protocol Conformance
extension InvertedTableViewCell: TableViewCell {
    func configure(viewModel: TableViewCellViewModel) {
        guard let model = viewModel as? InvertedCellViewModel else { return }
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
