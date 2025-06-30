//
//  MVVMRouterAppApp.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI
import Security

// MARK: - App Entry Point

@main
struct MVVMRouterApp: App {
    // The AuthManager is the source of truth for authentication state.
    @StateObject var authManager = AuthManager()
    // The router handles in-flow navigation (e.g., Login -> Register).
    @StateObject var router = Router()

    var body: some Scene {
        WindowGroup {
            // The NavigationStack is the root of our navigation hierarchy.
            NavigationStack(path: $router.path) {
                // RootView decides which view to show based on auth state.
                RootView()
                    .navigationDestination(for: Route.self) { route in
                        // The view a given route should navigate to.
                        route.view(router: router, authManager: authManager)
                    }
            }
            // The router and authManager are passed as environment objects.
            .environmentObject(router)
            .environmentObject(authManager)
        }
    }
}
