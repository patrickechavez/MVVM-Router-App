//
//  ProfileView.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.gray)
                .padding(.top, 40)
            
            Text("Profile for \(viewModel.username)")
                .font(.title2)
                .padding()
            
            // --- UPDATED: Three buttons for different presentation styles ---
            Button("Open Settings (Push)") {
                viewModel.goToSettingsAsPush()
            }
            .buttonStyle(.borderedProminent)

            Button("Open Settings (Sheet)") {
                viewModel.goToSettingsAsSheet()
            }
            .buttonStyle(.borderedProminent)

            Button("Open Settings (Full Screen)") {
                viewModel.goToSettingsAsFullScreen()
            }
            .buttonStyle(.borderedProminent)

            Button("Go Back") {
                viewModel.goBack()
            }
            .buttonStyle(.bordered)
            
            Spacer()
            
        }
        .navigationTitle("My Profile")
        .navigationBarBackButtonHidden(true)
    }
}
