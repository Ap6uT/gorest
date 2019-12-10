//
//  PostData.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation


class PostDataArray: Codable {
    var result = [PostData]()
}

class PostData: Codable, CustomStringConvertible {
    var description: String {
        return title ?? ""
    }
    
    var title: String?
    var text: String?
    var userID: String?
    var postID: String?
    
    
    enum CodingKeys: String, CodingKey {
        case text = "body"
        case userID = "user_id"
        case postID = "id"
        case title
    }
}
