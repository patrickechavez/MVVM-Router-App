//
//  DashboardViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

class DashboardViewModel: ObservableObject {
    private let coordinator: NavigationCoordinator
    private let authManager: AuthManager
    private let userRepository: UserRepositoryProtocol
    private let productRepository: ProductRepositoryProtocol
    
    @Published var users: [User] = []
    @Published var products: [Product] = []
    
    var user: String { authManager.username ?? "User" }
    
    init(coordinator: NavigationCoordinator,
         authManager: AuthManager,
         userRepository: UserRepositoryProtocol = UserRepository(),
         productRepository: ProductRepositoryProtocol = ProductRepository(),
    ) {
        self.coordinator = coordinator
        self.authManager = authManager
        self.userRepository = userRepository
        self.productRepository = productRepository

    }
    
    func fetchAllData() async {
        async let users = try? self.userRepository.getUsers()
        async let products = try? self.productRepository.getProducts()
        self.users = await users ?? []
        self.products = await products ?? []
    }
    
    func logout() {
        authManager.logout()
        coordinator.popToRoot()
    }
    
    func goToProfile() {
        coordinator.push(.profile(username: self.user))
    }
}


