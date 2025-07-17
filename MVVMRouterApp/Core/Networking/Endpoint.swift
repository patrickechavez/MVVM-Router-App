//
//  Endpoint.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", delete = "DELETE"
}

public enum AuthorizationType {
    case bearer
    case none
}

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: RequestTask { get }
    var authorizationType: AuthorizationType { get }
}

public enum RequestTask {
    case requestPlain
    case requestParameters(queryItems: [URLQueryItem])
    case requestJSONEncodable(Encodable)
    case requestMultipart(data: Data, fileName: String, mimeType: String, fieldName: String)
}
