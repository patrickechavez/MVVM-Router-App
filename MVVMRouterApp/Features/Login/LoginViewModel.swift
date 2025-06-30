//
//  LoginViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var errorMessage = ""

    private let coordinator: NavigationCoordinator
    private let authManager: AuthManager

    init(coordinator: NavigationCoordinator, authManager: AuthManager) {
        self.coordinator = coordinator
        self.authManager = authManager
    }

    func login() {
        if username.isEmpty || password.isEmpty {
            errorMessage = "Username and password cannot be empty."; hasError = true
        } else {
            authManager.login(username: username, token: username)
        }
    }
    
    func goToRegister() {
        coordinator.push(.register)
    }
}
