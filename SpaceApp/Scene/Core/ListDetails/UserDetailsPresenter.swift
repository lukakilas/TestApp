//
//  UserDetailsPresenter.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

protocol UserDetailsPresenter {
    func viewDidLoad()
}

class UserDetailsPresenterImpl: UserDetailsPresenter {
    private let useCase: DisplayUserDetailsUseCase
    private let parameters: UserDetailsPresenterParameters
    weak var view: UserDetailsView?
    private var userDetails: UserDetails?
    
    init(useCase: DisplayUserDetailsUseCase, parameters: UserDetailsPresenterParameters, view: UserDetailsView) {
        self.useCase = useCase
        self.parameters = parameters
        self.view = view
    }
    
    func viewDidLoad() {
        fetchDetails()
    }
    
    private func fetchDetails() {
        useCase.fetchDetails(with: parameters.userName) { [weak self] result in
            switch result {
            case .success(let details):
                self?.userDetails = details
            case .failure(let error):
                self?.view?.showError(error.localizedDescription)
            }
        }
    }
}
