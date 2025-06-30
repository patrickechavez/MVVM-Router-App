//
//  MVVMRouterAppApp.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

// MARK: - App Entry Point

@main
struct MVVMRouterApp: App {
    @StateObject var authManager = AuthManager()
    // The NavigationCoordinator now holds the navigation state.
    @StateObject var coordinator = NavigationCoordinator()

    var body: some Scene {
        WindowGroup {
            // The NavigationStack is bound directly to the coordinator's path.
            NavigationStack(path: $coordinator.path) {
//                // The RootView determines the first screen.
                RootView()
//                    // The navigationDestination modifier is centralized here.
//                    // It maps each NavigationDestination case to a specific View.
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        switch destination {
                        case .register:
                            RegisterView(viewModel: RegisterViewModel(coordinator: coordinator, authManager: authManager))
                        case .profile(let username):
                            ProfileView(viewModel: ProfileViewModel(coordinator: coordinator, authManager: authManager, username: username))
                        case .settings(let theme):
                            SettingsView(viewModel: SettingsViewModel(coordinator: coordinator, authManager: authManager, activeTheme: theme))
                        }
                    }
            }
            .sheet(item: $coordinator.presentedSheet) { destination in
                // Map the modal destination to a view
                switch destination {
                case .settings(let theme):
                    // ADD THIS WRAPPER 💡
                    NavigationStack {
                        SettingsView(viewModel: SettingsViewModel(coordinator: coordinator, authManager: authManager, activeTheme: theme))
                    }
                }
            }
            .fullScreenCover(item: $coordinator.presentedFullScreen) { destination in
                switch destination {
                case .settings(let theme):
                    // ADD THIS WRAPPER 💡
                    NavigationStack {
                        SettingsView(viewModel: SettingsViewModel(coordinator: coordinator, authManager: authManager, activeTheme: theme))
                    }
                }
            }
            .environmentObject(coordinator)
            .environmentObject(authManager)
        }
    }
}
