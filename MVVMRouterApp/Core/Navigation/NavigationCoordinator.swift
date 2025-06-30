//
//  NavigationCoordinator.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

// An ObservableObject to manage the navigation path.
// This is the single source of truth for navigation.
class NavigationCoordinator: ObservableObject {
    @Published var path = [NavigationDestination]()
    
    @Published var presentedSheet: ModalDestination?
    @Published var presentedFullScreen: ModalDestination?

    func push(_ destination: NavigationDestination) {
        path.append(destination)
    }

    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }
    
    // ADD THESE: Functions to trigger presentations
    func presentSheet(_ destination: ModalDestination) {
        self.presentedSheet = destination
    }
    
    func presentFullScreen(_ destination: ModalDestination) {
        self.presentedFullScreen = destination
    }
    
    func dismissModal() {
        self.presentedSheet = nil
        self.presentedFullScreen = nil
    }
}
