//
//  UserListConfigurator.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

class UserListConfigurator {
    func configure(for viewController: UserListController) {
        let saveUsersGateway = SaveUsersGatewayImpl()
        let apiFetchUsersGateway = ApiFetchUsersGatewayImplementation(saveUsersGateway: saveUsersGateway)
        let localFetchUsersGateway = LocalFetchUsersGatewayImplementation()
        let fetchUsersGateway = FetchUsersGateway(apiFetchUsersGateway: apiFetchUsersGateway,
                                                  localFetchUsersGateway: localFetchUsersGateway)
        let useCase = DisplayUsersUseCaseImplementation(gateway: fetchUsersGateway)
        let router = UserListRouterImpl(controller: viewController)
        let presenter: UserListPresenter = UserListPresenterImpl(useCase: useCase,
                                                                 view: viewController,
                                                                 router: router)
        viewController.presenter = presenter
    }
}
