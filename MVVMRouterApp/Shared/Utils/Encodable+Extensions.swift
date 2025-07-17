//
//  Encodable+Extensions.swift
//  MVVMRouterApp
//
//  Created by John Patrick Echavez on 7/18/25.
//

import Foundation

extension Encodable {
    func toQueryItems() -> [URLQueryItem]? {
        guard let data = try? JSONEncoder().encode(self),
              let dictionary = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return nil }
        return dictionary.compactMap { key, value in
            guard !(value is NSNull) else { return nil }
            return URLQueryItem(name: key, value: String(describing: value))
        }
    }
}
