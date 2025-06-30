//
//  AuthManager.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

// Manages the authentication state of the application.
class AuthManager: ObservableObject {
    // Published properties will trigger UI updates when they change.
    @Published var isAuthenticated = false
    @Published var username: String?


    init(isPreview: Bool = false) {
        if let token = KeychainHelper.loadToken() {
            self.username = token
            self.isAuthenticated = true
        }
    }

    // Handles the login process.
    func login(username: String, token: String) {
        // Save the token to the keychain.
        KeychainHelper.save(token: token)
        // Update the state to reflect that the user is logged in.
        self.username = username
        self.isAuthenticated = true
    }

    // Handles the logout process.
    func logout() {
        // Delete the token from the keychain.
        KeychainHelper.deleteToken()
        // Update the state to reflect that the user is logged out.
        self.username = nil
        self.isAuthenticated = false
    }
}
