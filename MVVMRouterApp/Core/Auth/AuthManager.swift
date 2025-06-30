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

    // Add a flag for previewing
    private var isPreview: Bool

    init(isPreview: Bool = false) {
        self.isPreview = isPreview
        // When the app starts, check if a token exists in the keychain, but not for previews
        if !isPreview, let token = KeychainHelper.loadToken() {
            self.username = token // For this example, the token is the username.
            self.isAuthenticated = true
        }
    }

    // Handles the login process.
    func login(username: String, token: String) {
        // Save the token to the keychain.
        if !isPreview { KeychainHelper.save(token: token) }
        // Update the state to reflect that the user is logged in.
        self.username = username
        self.isAuthenticated = true
    }

    // Handles the logout process.
    func logout() {
        // Delete the token from the keychain.
        if !isPreview { KeychainHelper.deleteToken() }
        // Update the state to reflect that the user is logged out.
        self.username = nil
        self.isAuthenticated = false
    }
}
