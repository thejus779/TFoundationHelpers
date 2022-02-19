//
//  URL+Extensions.swift
//
//
//  Created by Thejus Thejus on 29/12/2021.
//

import Foundation

extension URL {
    var params: [String: String]? {
        if let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true) {
            if let queryItems = urlComponents.queryItems {
                var params = [String: String]()
                queryItems.forEach {
                    params[$0.name] = $0.value
                }
                return params
            }
        }
        return nil
    }
}
extension URL: ExpressibleByStringLiteral {
    /// Creates an URL with any string literal
    public init(stringLiteral value: String) {
        self = URL(string: value)!
    }
}
