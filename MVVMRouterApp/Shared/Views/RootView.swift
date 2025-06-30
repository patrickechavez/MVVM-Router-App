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
    @EnvironmentObject var router: Router

    var body: some View {
        // If the user is authenticated, show the Dashboard as the root.
        // Otherwise, show the Login screen.
        if authManager.isAuthenticated {
            // We create the ViewModel here, passing the dependency.
            DashboardView(viewModel: DashboardViewModel(authManager: authManager))
        } else {
            LoginView(viewModel: LoginViewModel(router: router, authManager: authManager))
        }
    }
}
