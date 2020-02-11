//
//  extension.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


public typealias Parameters = [String: Any]

extension URL {

    func appendingQueryParameters(_ parameters: Parameters) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        var items = urlComponents.queryItems ?? []
        items += parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        urlComponents.queryItems = items
        return urlComponents.url!
    }

    mutating func appendQueryParameters(_ parameters: Parameters) {
        self = appendingQueryParameters(parameters)
    }
}
