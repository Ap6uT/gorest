//
//  RestResponse.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


struct RestResponse<T: Decodable>: Decodable {

    // MARK: Properties

    let result: T?
    let meta: Meta
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }

    // MARK: Types

    

}

public struct Meta: Decodable {
    let success: Bool?
    let code: Int?
    let totalCount: Int?
    let pageCount: Int?
    let currentPage: Int?
    let perPage: Int?
    let message: String?
}

/// Dummy struct used for empty Instagram API data responses.
public struct RestEmptyResponse: Decodable { }
