//
//  UserListRouter.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import UIKit

protocol UserListRouter {
    func showDetails(with userName: String)
}

class UserListRouterImpl: UserListRouter {
    
    weak var controller: UserListController?
    
    init(controller: UserListController) {
        self.controller = controller
    }
    
    func showDetails(with userName: String) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailsController") as? UserDetailsController {
            let _ = UserDetailsConfigurator().configure(for: vc, with: .init(userName: userName))
            controller?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
