//
//  RestPost.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation

public struct RestPost: Codable {
    
    public let title: String?
    public let text: String?
    public let userID: String?
    public let postID: String?
    
    
    enum CodingKeys: String, CodingKey {
        case text = "body"
        case userID = "user_id"
        case postID = "id"
        case title
    }
}
