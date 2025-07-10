//
//  DashboardView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome, \(viewModel.user)!").font(.largeTitle)
            
            // Add this button
            Button("View Profile") {
                viewModel.goToProfile()
            }
            .buttonStyle(.borderedProminent)

            Button("Log Out") {
                viewModel.logout()
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .navigationTitle("Dashboard")
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    DashboardView(viewModel: DashboardViewModel(
        coordinator: NavigationCoordinator(),
        authManager: AuthManager(),
        userRepository: UserRepository(),
        productRepository: ProductRepository())
    )
    
}
