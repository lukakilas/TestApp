//
//  UserListPresenter.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

protocol UserListPresenter {
    func viewDidLoad()
    func numberOfRows() -> Int
    func idForCell(at indexPath: IndexPath) -> String
    func configure(_ cell: TableViewCell, at indexPath: IndexPath)
    func filterUsers(with keyword: String)
    func refreshData()
    func didSelectRow(at indexPath: IndexPath)
}

class UserListPresenterImpl: UserListPresenter {

    private weak var view: UserListView?
    private let useCase: DisplayUsersUseCase
    private let router: UserListRouter
    private var users: [User] = []
    private var dataSource: [User] = []
    
    
    init(useCase: DisplayUsersUseCase,
         view: UserListView?,
         router: UserListRouter) {
        self.useCase = useCase
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        fetchUsersList()
    }
    
    func numberOfRows() -> Int {
        dataSource.count
    }
    
    func idForCell(at indexPath: IndexPath) -> String {
        dataSource[indexPath.row].getNormalCellModel.reuseId
    }
    
    func configure(_ cell: TableViewCell, at indexPath: IndexPath) {
        let viewModel = dataSource[indexPath.row].getNormalCellModel
        cell.configure(viewModel: viewModel)
    }
    
    func filterUsers(with keyword: String) {
        dataSource =  keyword.isEmpty ? users : users.filter({$0.login.contains(keyword)})
        view?.reloadData()
    }
    
    func refreshData() {
        fetchUsersList()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let userName = dataSource[indexPath.row].login
        router.showDetails(with: userName)
    }
}

// MARK: - Data Fetching
extension UserListPresenterImpl {
    private func fetchUsersList() {
        NetworkWathcer.shared.connectionStatus == .connected ? fetchUsersFromApi() : fetchUsersFromDataBase()
    }
    
    private func fetchUsersFromApi() {
        view?.startLoader()
        useCase.fetchUsersFromApi { [weak self] result in
            guard let self = self else { return }
            self.view?.stopLoader()
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                    self.dataSource = users
                    self.view?.reloadData()
                }
                
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    private func fetchUsersFromDataBase() {
        view?.startLoader()
        useCase.fetchUsersFromDataBase { [weak self] result in
            guard let self = self else { return }
            self.view?.stopLoader()
            switch result {
            case .success(let users):
                self.dataSource = users
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
}
