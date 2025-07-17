//
//  Product.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

struct Product: Codable, Identifiable, Hashable {
    let id: Int
    let userId: Int
    var title: String
    var body: String
}
