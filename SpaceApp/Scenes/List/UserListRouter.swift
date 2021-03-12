//
//  UserListRouter.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

protocol UserListRouter {
    func showDetails(with parameters: UserDetailsPresenterModel)
}

class UserListRouterImpl: UserListRouter {
    
    weak var controller: UserListController?
    
    init(controller: UserListController) {
        self.controller = controller
    }
    
    func showDetails(with parameters: UserDetailsPresenterModel) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailsController") as? UserDetailsController {
            let _ = UserDetailsConfigurator().configure(for: vc, with: parameters)
            controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
