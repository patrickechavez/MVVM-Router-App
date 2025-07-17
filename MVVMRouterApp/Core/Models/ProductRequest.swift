//
//  ProductRequest.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

public struct ProductRequest: Encodable {
    let userId: Int
    let title: String
    let body: String
}
