//
//  UserRepository.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(filter: UserFilter?) async throws -> [User]
}

class UserRepository: UserRepositoryProtocol {
    private let networkService: NetworkService
    init(networkService: NetworkService = NetworkService()) { self.networkService = networkService }

    func fetchUsers(filter: UserFilter?) async throws -> [User] {
        try await networkService.request(endpoint: APIEndpoint.getUsers(filters: filter))
    }
}
