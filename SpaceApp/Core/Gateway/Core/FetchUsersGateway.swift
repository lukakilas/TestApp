//
//  FetchUsersGateway.swift
//  SpaceApp
//
//  Created by Luka Kilasonia on 10.03.21.
//

import Foundation

class FetchUsersGateway {
    var apiFetchUsersGateway: ApiFetchUsersGateway
    var localFetchUsersGateway: LocalFetchUsersGateway
    
    init(apiFetchUsersGateway: ApiFetchUsersGateway,
        localFetchUsersGateway: LocalFetchUsersGateway) {
        self.apiFetchUsersGateway = apiFetchUsersGateway
        self.localFetchUsersGateway = localFetchUsersGateway
    }
}


