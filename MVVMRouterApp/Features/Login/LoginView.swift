//
//  LoginView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Login").font(.largeTitle).fontWeight(.bold)
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                viewModel.login()
            }
            .buttonStyle(.borderedProminent)
            Button("Don't have an account? Register") {
                viewModel.goToRegister()
            }
        }
        .padding()
        .navigationTitle("Login")
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(
        coordinator: NavigationCoordinator(),
        authManager: AuthManager())
    )
}
