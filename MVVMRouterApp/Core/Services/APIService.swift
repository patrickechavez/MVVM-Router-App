//
//  APIService.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/9/25.
//
import Foundation

// File: Core/Services/APIService.swift

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed(description: String)
    case decodingFailed(description: String)
}

// IMPROVEMENT: The protocol now explicitly includes 'requiresAuth'.
protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var requiresAuth: Bool { get }
}

// Provide a default for requiresAuth so it's opt-in.
extension Endpoint {
    var requiresAuth: Bool { return false }
}

enum APIEndpoint: Endpoint {
    // User Endpoints
    case getUsers
    
    // Product Endpoints
    case getProducts
    case createProduct(title: String)
    case updateProduct(id: String, title: String)
    case deleteProduct(id: String)
    
    // NEW CASE: For uploading an image.
    case uploadImage(imageData: Data)

    var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }

    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .getProducts, .createProduct:
            return "/posts"
        case .updateProduct(let id, _), .deleteProduct(let id):
            return "/posts/\(id)"
        case .uploadImage:
            return "/photos" // Example upload path
        }
    }

    var method: String {
        switch self {
        case .getUsers, .getProducts: return "GET"
        case .createProduct, .uploadImage: return "POST"
        case .updateProduct: return "PUT"
        case .deleteProduct: return "DELETE"
        }
    }
    
    // IMPROVEMENT: Endpoints now explicitly declare if they need auth.
    var requiresAuth: Bool {
        switch self {
        case .getUsers, .getProducts:
            return false
        case .createProduct, .updateProduct, .deleteProduct, .uploadImage:
            return true
        }
    }

    var headers: [String: String]? {
        // For file uploads, we need a different Content-Type.
        if case .uploadImage = self {
            return ["Content-Type": "multipart/form-data; boundary=\(boundary)"]
        }
        
        // For all other requests, use JSON.
        var headers = ["Content-Type": "application/json; charset=utf-8"]
        if self.requiresAuth, let token = KeychainHelper.loadToken() {
            headers["Authorization"] = "Bearer \(token)"
        }
        return headers
    }

    var body: Data? {
        switch self {
        case .getUsers, .getProducts, .deleteProduct:
            return nil
        case .createProduct(let title), .updateProduct(_, let title):
            let params = ["title": title]
            return try? JSONEncoder().encode(params)
        case .uploadImage(let imageData):
            // For file uploads, we construct a special multipart body.
            return createMultipartBody(imageData: imageData)
        }
    }
    
    // Private helpers for file uploads, kept inside the enum.
    private var boundary: String { "Boundary-\(UUID().uuidString)" }

    private func createMultipartBody(imageData: Data) -> Data {
        var body = Data()
        let fieldName = "file"
        let filename = "image.jpg"
        let mimetype = "image/jpeg"

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
}

// IMPROVEMENT: No longer a singleton. It's now injectable.
struct APIService {
    // The initializer is now public.
    init() {}
    
    func request<T: Decodable>(endpoint: Endpoint, responseType: T.Type = T.self) async throws -> T {
        guard let url = URL(string: endpoint.path, relativeTo: endpoint.baseURL) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = endpoint.headers
        request.httpBody = endpoint.body
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw APIError.requestFailed(description: "Invalid response with status code: \(statusCode)")
        }
        
        if T.self == EmptyResponse.self {
            return EmptyResponse() as! T
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decodingFailed(description: error.localizedDescription)
        }
    }
}
