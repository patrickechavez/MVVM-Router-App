//
//  ProductViewModel.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//

import Foundation

@MainActor
class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let repository: ProductRepositoryProtocol
    init(repository: ProductRepositoryProtocol = ProductRepository()) { self.repository = repository }
    
    // --- READ ---
    func fetchAllProducts() async {
        await fetch(filter: nil)
    }
    
    func searchProducts(byUserId userId: Int) async {
        await fetch(filter: ProductFilter(userId: userId))
    }
    
    private func fetch(filter: ProductFilter?) async {
        isLoading = true
        errorMessage = nil
        do {
            products = try await repository.fetchProducts(filter: filter)
        } catch {
            errorMessage = "Failed to fetch products: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // --- CREATE ---
    func addProduct(title: String, body: String, userId: Int) async {
        isLoading = true
        errorMessage = nil
        let request = ProductRequest(userId: userId, title: title, body: body)
        do {
            let newProduct = try await repository.createProduct(request)
            products.insert(newProduct, at: 0)
        } catch {
            errorMessage = "Failed to create product: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // --- UPDATE ---
    func updateProduct(id: Int, newTitle: String, newBody: String) async {
        guard let index = products.firstIndex(where: { $0.id == id }) else { return }
        let product = products[index]
        let request = ProductRequest(userId: product.userId, title: newTitle, body: newBody)
        
        do {
            var updatedProduct = try await repository.updateProduct(id: id, request)
            products[index] = updatedProduct
        } catch {
            errorMessage = "Failed to update product: \(error.localizedDescription)"
        }
    }
    
    // --- DELETE ---
    func deleteProduct(id: Int) async {
        do {
            try await repository.deleteProduct(id: id)
            products.removeAll { $0.id == id }
        } catch {
            errorMessage = "Failed to delete product: \(error.localizedDescription)"
        }
    }
}
