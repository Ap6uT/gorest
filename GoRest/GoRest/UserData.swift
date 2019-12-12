//
//  UserData.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class UserDataArray: Codable {
    var result: UserData?
    
    var meta: MetaData?
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

class UserData: Codable, CustomStringConvertible {
    var description: String {
        return "\(firstName ?? "") \(lastName ?? "")"
    }
    
    var firstName: String?
    var lastName: String?
    var website: String?
    var status: String?
    var links: UserAvatar?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case status, website
        case links = "_links"
    }
}

class UserLinks: Codable {
    var links: UserAvatar?
    
    enum CodingKeys: String, CodingKey {
        case links = "_links"
    }
}

class UserAvatar: Codable {
    var avatar: UserAvatarHref?
}

class UserAvatarHref: Codable {
    var link: String?
    
    enum CodingKeys: String, CodingKey {
        case link = "href"
    }
}
