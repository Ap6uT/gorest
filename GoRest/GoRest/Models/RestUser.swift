//
//  RestUser.swift
//  GoRest
//
//  Created by Alexander Grishin on 29.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


public struct RestUser: Codable {

    public let firstName: String?
    public let lastName: String?
    public let website: String?
    public let status: String?
    public let links: UserLinks?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case status, website
        case links = "_links"
    }
    
    public struct UserLinks: Codable {
        public let avatar: UserAvatarLink?
    }

    public struct UserAvatarLink: Codable {
        public let link: String?
        
        enum CodingKeys: String, CodingKey {
            case link = "href"
        }
    }
}



