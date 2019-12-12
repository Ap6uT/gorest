//
//  CommentsData.swift
//  GoRest
//
//  Created by Alexander Grishin on 12.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class CommentsDataArray: Codable {
    var result = [CommentsData]()
    var meta = MetaData()
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

class CommentsData: Codable {
    var postId: String?
    var name: String?
    var body: String?
    
    enum CodingKeys: String, CodingKey {
        case postId = "post_id"
        case body
        case name
    }
}
