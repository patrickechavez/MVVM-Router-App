//
//  SettingsView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

// The UI for the Settings screen
struct SettingsView: View {
    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
            Text("App Settings")
                .font(.title)
            List {
                Toggle("Enable Notifications", isOn: .constant(true))
                Toggle("Dark Mode", isOn: .constant(false))
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                }
            }
            Button("Dismiss Modal") {
                viewModel.dismiss()
            }
            
            // Add this button to navigate to Settings
            Button("Back to Previous Screen") {
                viewModel.goBack()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Back to Root") {
                viewModel.goToRoot()
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    SettingsView(
        viewModel: SettingsViewModel(
            coordinator: NavigationCoordinator(),
            authManager: AuthManager(),
            activeTheme: ""
        )
    )
    
}
