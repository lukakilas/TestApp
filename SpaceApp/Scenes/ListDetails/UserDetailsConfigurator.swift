//
//  UserDetailsConfigurator.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

class UserDetailsConfigurator {
    func configure(for viewController: UserDetailsController, with parameters: UserDetailsPresenterModel) {
        let gateway = ApiFetchUserDetailsGatewayImpl()
        let displayUserDetailsUseCase = DisplayUserDetailsUseCaseImpl(gateway: gateway)
        let saveUserNotesUseCase = SaveUserNotesUseCaseImpl(gateway: SaveUserNotesGatewayImpl())
        let presenter = UserDetailsPresenterImpl(displayUserDetailsUseCase: displayUserDetailsUseCase,
                                                 saveUserNoteUseCase: saveUserNotesUseCase,
                                                 parameters: parameters,
                                                 view: viewController)
        viewController.presenter = presenter
    }
}
