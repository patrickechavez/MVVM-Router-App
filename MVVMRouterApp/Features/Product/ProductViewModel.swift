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
    
    // Dependency is now injected
    private let repository: ProductRepositoryProtocol

    // The initializer now REQUIRES a repository.
    init(repository: ProductRepositoryProtocol) {
        self.repository = repository
    }

    func fetchProducts() async {
        products = (try? await repository.getProducts()) ?? []
    }
    
    func addProduct(title: String) async {
        guard let newProduct = try? await repository.createProduct(title: title) else { return }
        products.insert(newProduct, at: 0)
    }
    
    func updateProduct(_ product: Product) async {
        let updatedTitle = product.name + " (Updated)"
        guard let updatedProduct = try? await repository.updateProduct(id: product.id, title: updatedTitle) else { return }
        
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            products[index] = updatedProduct
        }
    }
    
    func deleteProduct(at offsets: IndexSet) {
        let productsToDelete = offsets.map { products[$0] }
        products.remove(atOffsets: offsets)
        
        Task {
            for product in productsToDelete {
                try? await repository.deleteProduct(id: product.id)
            }
        }
    }
}
