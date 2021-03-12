//
//  GenericListView.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

protocol GenericListView: class {
    func reloadData()
    func showError(_ error: String)
}
