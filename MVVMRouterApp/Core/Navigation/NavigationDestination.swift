//
//  NavigationDestination.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 6/28/25.
//

import Foundation

enum NavigationDestination: Codable, Hashable {
    case register
    case profile(username: String)
    case settings(theme: String)
}
