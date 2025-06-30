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
    
    var user: String { authManager.username ?? "User" }
    
    init(coordinator: NavigationCoordinator, authManager: AuthManager) {
        self.coordinator = coordinator
        self.authManager = authManager
    }
    
    func logout() {
        authManager.logout()
        coordinator.popToRoot()
    }
    
    func goToProfile() {
        coordinator.push(.profile(username: self.user))
    }
}


