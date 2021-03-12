//
//  UserListController.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit
import CoreData

protocol UserListView: GenericListView {
    func startLoader()
    func stopLoader()
}

class UserListController: UIViewController {
    
    var presenter: UserListPresenter!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchField: UITextField!
    @IBOutlet private weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserListConfigurator().configure(for: self)
        registerCells()
        subscribeNetworkChanges()
        setupSearchField()
        presenter.viewDidLoad()
    }

    private func setupSearchField() {
        searchField.addTarget(self, action: #selector(searchFieldEditingChanged(_:)), for: .editingChanged)
    }
    
    private func registerCells() {
        tableView.register(NormalTableViewCell.self, forCellReuseIdentifier: "NormalTableViewCell")
        tableView.register(NotyTableViewCell.self, forCellReuseIdentifier: "NotyTableViewCell")
        tableView.register(InvertedTableViewCell.self, forCellReuseIdentifier: "InvertedTableViewCell")
    }
    
    // MARK: - Selector Functions
    @objc private func searchFieldEditingChanged(_ searchField: UITextField) {
        guard let keyword = searchField.text else { return }
        presenter.filterUsers(with: keyword)
    }
    
    // MARK: - IBActions
    @IBAction func reloadClicked(_ sender: Any) {
        presenter.refreshData()
    }
}

// MARK: - UserListView Conformance
extension UserListController: UserListView {
    func startLoader() {
        loader.isHidden = false
        loader.startAnimating()
    }
    
    func stopLoader() {
        loader.isHidden = true
        loader.stopAnimating()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func showError(_ error: String) {
        self.showAlert(title: "Error Occured", text: error)
    }
}

// MARK: - TableView DataSource
extension UserListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseId = presenter.idForCell(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as? TableViewCell
        presenter.configure(cell!, at: indexPath)
        return cell!
    }
}

extension UserListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}
