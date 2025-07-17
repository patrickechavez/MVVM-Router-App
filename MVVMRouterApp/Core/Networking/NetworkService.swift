//
//  NetworkService.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

class NetworkService {
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let urlRequest = try buildRequest(from: endpoint)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            try handleResponse(response)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return decodedObject
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw APIError.noInternetConnection
        } catch let error as DecodingError {
            throw APIError.decodingFailed(error)
        }
    }

    /// Performs a request that does not return a body (e.g., DELETE).
    func request(endpoint: Endpoint) async throws {
        let urlRequest = try buildRequest(from: endpoint)
        
        do {
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            try handleResponse(response)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            throw APIError.noInternetConnection
        }
    }

    private func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        guard let url = URL(string: endpoint.path, relativeTo: endpoint.baseURL) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        switch endpoint.authorizationType {
        case .bearer:
            guard let token = KeychainHelper.loadToken() else {
                throw APIError.unauthorized
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        case .none:
            break
        }

        switch endpoint.task {
        case .requestPlain:
            break
            
        case .requestParameters(let queryItems):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let urlWithParams = components?.url else { throw APIError.invalidURL }
            request.url = urlWithParams
            
        case .requestJSONEncodable(let body):
            request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                throw APIError.encodingFailed
            }
            
        case .requestMultipart(let data, let fileName, let mimeType, let fieldName):
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = createMultipartBody(
                boundary: boundary,
                data: data,
                mimeType: mimeType,
                fileName: fileName,
                fieldName: fieldName
            )
        }
        
        return request
    }
    
    // ✨ IMPROVED: More specific error handling based on status codes
    private func handleResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.requestFailed
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            break
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        case 500...599:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw APIError.requestFailed
        }
    }
    
    private func createMultipartBody(boundary: String, data: Data, mimeType: String, fileName: String, fieldName: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"
        
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\(lineBreak)")
        body.append("Content-Type: \(mimeType)\(lineBreak)\(lineBreak)")
        body.append(data)
        body.append(lineBreak)
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
}

// Helper to append string to Data
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
