//
//  UserRepository.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers() async throws -> [User]
}

class UserRepository: UserRepositoryProtocol {
    private let apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }

    func getUsers() async throws -> [User] {
        return try await apiService.request(endpoint: APIEndpoint.getUsers)
    }
}
