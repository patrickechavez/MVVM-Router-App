//
//  APIError.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

public enum APIError: Error, LocalizedError {
    case unauthorized
    case requestFailed
    case invalidURL
    case notFound
    case serverError(statusCode: Int)
    case noInternetConnection
    case decodingFailed(Error)
    case encodingFailed

    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Your session has expired. Please log in again."
        case .requestFailed:
            return "The request failed. Please try again."
        case .invalidURL:
            return "There was an issue connecting to the server."
        case .notFound:
            return "The content you're looking for could not be found."
        case .serverError(let statusCode):
            return "There seems to be a problem with our server (Code: \(statusCode)). Please try again later."
        case .noInternetConnection:
            return "No internet connection. Please check your connection and try again."
        case .decodingFailed:
            return "There was an issue processing the data from the server."
        case .encodingFailed:
            return "There was an issue sending your data. Please try again."
        }
    }
}
