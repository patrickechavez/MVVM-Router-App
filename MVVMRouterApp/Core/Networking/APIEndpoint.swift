//
//  APIEndpoint.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

public enum APIEndpoint {
    case getUsers(filters: UserFilter?)
    case getProducts(filters: ProductFilter?)
    case createProduct(product: ProductRequest)
    case updateProduct(id: Int, product: ProductRequest)
    case deleteProduct(id: Int)
    case uploadImage(data: Data)
}

extension APIEndpoint: Endpoint {

    public var baseURL: URL { URL(string: "https://jsonplaceholder.typicode.com")! }
    
    public var path: String {
        switch self {
        case .getUsers: return "/users"
        case .getProducts, .createProduct: return "/posts"
        case .updateProduct(let id, _), .deleteProduct(let id): return "/posts/\(id)"
        case .uploadImage: return "/photos"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getUsers, .getProducts: return .get
        case .createProduct, .uploadImage: return .post
        case .updateProduct: return .put
        case .deleteProduct: return .delete
        }
    }
    
    public var task: RequestTask {
        switch self {
        case .getUsers(let filters):
            if let items = filters?.toQueryItems(), !items.isEmpty { return .requestParameters(queryItems: items) }
            return .requestPlain
        case .getProducts(let filters):
            if let items = filters?.toQueryItems(), !items.isEmpty { return .requestParameters(queryItems: items) }
            return .requestPlain
        case .createProduct(let product), .updateProduct(_, let product):
            return .requestJSONEncodable(product)
        case .deleteProduct:
            return .requestPlain
        case .uploadImage(let data):
            return .requestMultipart(data: data, fileName: "image.jpg", mimeType: "image/jpeg", fieldName: "file")
        }
    }
    
    public var authorizationType: AuthorizationType {
        switch self {
        case .getUsers, .getProducts:
            return .none
            
        case .createProduct, .updateProduct, .deleteProduct, .uploadImage:
            return .bearer
        }
    }
}
