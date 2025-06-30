//
//  RegisterViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

class RegisterViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var hasError = false
    @Published var errorMessage = ""

    private let router: Router
    private let authManager: AuthManager

    init(router: Router, authManager: AuthManager) {
        self.router = router
        self.authManager = authManager
    }

    func register() {
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            hasError = true
            return
        }
        if username.isEmpty || password.isEmpty {
            errorMessage = "Fields cannot be empty."
            hasError = true
            return
        }
        // After successful registration, log the user in.
        authManager.login(username: username, token: username)
    }
}
