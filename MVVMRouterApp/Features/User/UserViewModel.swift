//
//  UserViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: UserRepositoryProtocol
    init(repository: UserRepositoryProtocol = UserRepository()) { self.repository = repository }

    func fetchAllUsers() async {
        await fetch(filter: nil)
    }
    
    func searchUser(username: String) async {
        let filter = username.isEmpty ? nil : UserFilter(username: username)
        await fetch(filter: filter)
    }
    
    private func fetch(filter: UserFilter?) async {
        isLoading = true
        errorMessage = nil
        do {
            users = try await repository.fetchUsers(filter: filter)
        } catch {
            errorMessage = "Failed to fetch users: \(error.localizedDescription)"
        }
        isLoading = false
    }
}
