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
            ZStack(alignment: .trailing) {
                       // TextField
                TextField("Select a Country", text: $viewModel.username)
                           .disabled(true)  // Make it non-editable
                           .frame(width: 300, alignment: .leading) // Align text to the left
                           .padding()
                           .background(Color(.secondarySystemBackground))
                           .clipShape(RoundedRectangle(cornerRadius: 10))
                           .onTapGesture {
                               viewModel.username = "Hello World"
                           }

                       // Chevron Down Icon above TextField
                       Image(systemName: "chevron.down")
                           .foregroundColor(.gray)
                           .padding(.trailing)
                   }
                  
                
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
