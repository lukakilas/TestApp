//
//  TableViewCellProtocol.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

protocol TableViewCellViewModel {
    var title: String { get }
    var reuseId: String { get }
}

protocol TableViewCell: UITableViewCell {
    func configure(viewModel: TableViewCellViewModel)
}
