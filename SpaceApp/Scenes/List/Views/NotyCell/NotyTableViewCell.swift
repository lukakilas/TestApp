//
//  NotyTableViewCell.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import UIKit

class NotyTableViewCell: UserListTableViewCell {
    override var reuseIdentifier: String? { return "NotyTableViewCell" }
    
    private let noteIcon: UIImageView = {
        let image = UIImage(named: "note_icon")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupNoteIcon()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNoteIcon()
    }
    
    private func setupNoteIcon() {
        contentView.addSubview(noteIcon)
        NSLayoutConstraint.activate([
            noteIcon.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            noteIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            noteIcon.widthAnchor.constraint(equalToConstant: 20),
            noteIcon.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

// MARK: - TableViewCell Protocol Conformance
extension NotyTableViewCell: TableViewCell {
    func configure(viewModel: TableViewCellViewModel) {
        guard let model = viewModel as? NotyCellViewModel else { return }
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
