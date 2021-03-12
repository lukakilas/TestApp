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
    private var notyUsers: [User] = []
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
        let viewModel = createCellViewModel(for: indexPath)
        return viewModel.reuseId
    }
    
    func configure(_ cell: TableViewCell, at indexPath: IndexPath) {
        let viewModel = createCellViewModel(for: indexPath)
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
        let user = dataSource[indexPath.row]
        let parameters = UserDetailsPresenterModel(userName: user.login,
                                                        userId: user.id,
                                                        notes: user.notes)
        router.showDetails(with: parameters)
    }
}

// MARK: - Data Fetching
extension UserListPresenterImpl {
    private func fetchUsersList() {
        fetchUsersFromApi()
        fetchUsersFromDataBase()
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
                    let matched = self.matchWithDatabaseUsersForNotes()
                    self.dataSource = matched
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
                self.users = users
                self.dataSource = users
                self.pickNotyUsers(from: users)
                self.view?.reloadData()
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
    
    private func pickNotyUsers(from users: [User]) {
        users.forEach { (user) in
            guard let _ = user.notes else { return }
            notyUsers.append(user)
        }
    }
    
    func matchWithDatabaseUsersForNotes() -> [User] {
        let common = notyUsers.filter{users.contains($0)}
        common.forEach { (user) in
            let userToModify = users.first(where: {$0.id == user.id})
            userToModify?.notes = user.notes
        }
        return users
    }
}

// MARK: - Cell ViewModels Generating
extension UserListPresenterImpl {
    func createCellViewModel(for indexPath: IndexPath) -> TableViewCellViewModel {
        
        let user = dataSource[indexPath.row]
        let avatarDownloadUseCase = DownloadAvatarUseCaseImpl(urlString: user.avatar_url,
                                                              saveAvatarGateway: SaveAvatarGatewayImpl())
        
        if (indexPath.row + 1) % 3 == .zero {
            return InvertedCellViewModel(title: user.login,
                                         description: user.node_id,
                                         imageData: user.imageData,
                                         imageDownloadUseCase: avatarDownloadUseCase)
            
        } else if user.notes != nil {
            return NotyCellViewModel(title: user.login,
                                     description: user.node_id,
                                     imageData: user.imageData,
                                     imageDownloadUseCase: avatarDownloadUseCase)
        }
        return NormalCellViewModel(title: user.login,
                                   description: user.node_id,
                                   imageData: user.imageData,
                                   imageDownloadUseCase: avatarDownloadUseCase)
    }
}

