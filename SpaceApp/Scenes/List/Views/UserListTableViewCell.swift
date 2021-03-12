//
//  UserListTableViewCell.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 12.03.21.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let iconContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descriptionLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        insertSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        roundCornersToImageContainerView()
    }
    
    // MARK: - Setup()
    private func insertSubviews() {
        contentView.addSubview(iconContainerView)
        iconContainerView.addSubview(iconImageView)
        contentView.addSubview(titleLbl)
        contentView.addSubview(descriptionLbl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            iconContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            iconContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            iconContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            iconContainerView.widthAnchor.constraint(equalToConstant: 55),
            iconContainerView.heightAnchor.constraint(equalToConstant: 55),
            iconImageView.leftAnchor.constraint(equalTo: iconContainerView.leftAnchor, constant: 10),
            iconImageView.rightAnchor.constraint(equalTo: iconContainerView.rightAnchor, constant: -10),
            iconImageView.topAnchor.constraint(equalTo: iconContainerView.topAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: iconContainerView.bottomAnchor, constant: -10),
            titleLbl.leftAnchor.constraint(equalTo: iconContainerView.rightAnchor, constant: 10),
            titleLbl.topAnchor.constraint(equalTo: iconContainerView.topAnchor),
            titleLbl.rightAnchor.constraint(greaterThanOrEqualTo: contentView.rightAnchor, constant: -16),
            descriptionLbl.leadingAnchor.constraint(equalTo: titleLbl.leadingAnchor),
            descriptionLbl.trailingAnchor.constraint(equalTo: titleLbl.trailingAnchor),
            descriptionLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10),
            ])
    }
    
    private func roundCornersToImageContainerView() {
        iconContainerView.layer.cornerRadius = iconContainerView.frame.width/2
        iconContainerView.clipsToBounds = true
        iconContainerView.layer.borderWidth = 1
        iconContainerView.layer.borderColor = UIColor.black.cgColor
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView.clipsToBounds = true
    }
    
}

