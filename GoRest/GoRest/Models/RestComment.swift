//
//  RestComment.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


public struct RestComment: Codable {
    public let postId: String?
    public let name: String?
    public let body: String?
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case body
        case name
    }
}
