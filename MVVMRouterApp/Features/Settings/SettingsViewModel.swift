//
//  SettingsViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

class SettingsViewModel: ObservableObject {
    private let coordinator: NavigationCoordinator
    private let authManager: AuthManager
    @Published var activeTheme: String
    
    init(coordinator: NavigationCoordinator, authManager: AuthManager, activeTheme: String) {
        self.coordinator = coordinator
        self.authManager = authManager
        self.activeTheme = activeTheme
    }
    
    // Function to navigate to settings
    func goToRoot() {
        coordinator.popToRoot()
    }
    
    func dismiss() {
        coordinator.dismissModal()
    }
    
    // Function to go back to the previous screen (Dashboard)
    func goBack() {
        coordinator.pop()
    }
    
    func logOut() {
        authManager.logout()
    }
}
