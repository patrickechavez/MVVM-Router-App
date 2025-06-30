//
//  RegisterView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel: RegisterViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Register").font(.largeTitle).fontWeight(.bold)
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .disableAutocorrection(true)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Register") {
                viewModel.register()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("Register")
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK")))
        }
    }
}
