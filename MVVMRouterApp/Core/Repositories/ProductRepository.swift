//
//  ProductRepository.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    func fetchProducts(filter: ProductFilter?) async throws -> [Product]
    func createProduct(_ request: ProductRequest) async throws -> Product
    func updateProduct(id: Int, _ request: ProductRequest) async throws -> Product
    func deleteProduct(id: Int) async throws
}

class ProductRepository: ProductRepositoryProtocol {
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }

    func fetchProducts(filter: ProductFilter?) async throws -> [Product] {
        try await networkService.request(endpoint: APIEndpoint.getProducts(filters: filter))
    }
    func createProduct(_ request: ProductRequest) async throws -> Product {
        try await networkService.request(endpoint: APIEndpoint.createProduct(product: request))
    }
    func updateProduct(id: Int, _ request: ProductRequest) async throws -> Product {
        try await networkService.request(endpoint: APIEndpoint.updateProduct(id: id, product: request))
    }
    func deleteProduct(id: Int) async throws {
        try await networkService.request(endpoint: APIEndpoint.deleteProduct(id: id))
    }
}
