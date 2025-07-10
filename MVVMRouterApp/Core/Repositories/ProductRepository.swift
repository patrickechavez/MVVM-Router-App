//
//  ProductRepository.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

protocol ProductRepositoryProtocol {
    func getProducts() async throws -> [Product]
    func createProduct(title: String) async throws -> Product
    func updateProduct(id: String, title: String) async throws -> Product
    func deleteProduct(id: String) async throws
}

class ProductRepository: ProductRepositoryProtocol {
    
    private let apiService: APIService

    init(apiService: APIService = APIService()) {
        self.apiService = apiService
    }
    
    func getProducts() async throws -> [Product] {
        return try await apiService.request(endpoint: APIEndpoint.getProducts)
    }
    
    func createProduct(title: String) async throws -> Product {
        return try await apiService.request(endpoint: APIEndpoint.createProduct(title: title))
    }
    
    func updateProduct(id: String, title: String) async throws -> Product {
        return try await apiService.request(endpoint: APIEndpoint.updateProduct(id: id, title: title))
    }
    
    func deleteProduct(id: String) async throws {
        _ = try await apiService.request(endpoint: APIEndpoint.deleteProduct(id: id), responseType: EmptyResponse.self)
    }
}
