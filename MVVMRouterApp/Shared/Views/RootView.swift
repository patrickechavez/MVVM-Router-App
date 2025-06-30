//
//  RootView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

// This view acts as a switch, showing the correct root screen based on auth state.
struct RootView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var coordinator: NavigationCoordinator

    var body: some View {
        if authManager.isAuthenticated {
            DashboardView(viewModel: DashboardViewModel(coordinator: coordinator, authManager: authManager))
        } else {
            LoginView(viewModel: LoginViewModel(coordinator: coordinator, authManager: authManager))
        }
    }
}

#Preview {
    RootView()
        .environmentObject(AuthManager())
        .environmentObject(NavigationCoordinator())
}
