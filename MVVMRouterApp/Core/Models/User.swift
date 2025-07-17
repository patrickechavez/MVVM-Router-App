//
//  User.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

public struct User: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String
    public let username: String
    public let email: String
}
