//
//  UserDetailsConfigurator.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

class UserDetailsConfigurator {
    func configure(for viewController: UserDetailsController, with parameters: UserDetailsPresenterParameters) {
        let gateway = ApiFetchUserDetailsGatewayImpl()
        let usecase = DisplayUserDetailsUseCaseImpl(gateway: gateway)
        let presenter = UserDetailsPresenterImpl(useCase: usecase,
                                                 parameters: parameters,
                                                 view: viewController)
        viewController.presenter = presenter
    }
}
