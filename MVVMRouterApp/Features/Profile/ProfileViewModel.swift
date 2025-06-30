//
//  ProfileViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    private let coordinator: NavigationCoordinator
    private let authManager: AuthManager
    @Published var username: String
    @Published var preferredTheme = "Dark"
    
    init(coordinator: NavigationCoordinator, authManager: AuthManager, username: String, preferredTheme: String = "Dark") {
        self.coordinator = coordinator
        self.authManager = authManager
        self.username = username
        self.preferredTheme = preferredTheme
    }
    
    func goToSettingsAsPush() {
        coordinator.push(.settings(theme: preferredTheme))
    }

    func goToSettingsAsSheet() {
        coordinator.presentSheet(.settings(theme: preferredTheme))
    }

    func goToSettingsAsFullScreen() {
        coordinator.presentFullScreen(.settings(theme: preferredTheme))
    }

    func goBack() {
        coordinator.pop()
    }
}
