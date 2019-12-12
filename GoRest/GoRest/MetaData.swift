//
//  MetaData.swift
//  GoRest
//
//  Created by Alexander Grishin on 12.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class MetaData: Codable {
    var success: Bool?
    var code: Int?
    var totalCount: Int?
    var pageCount: Int?
    var currentPage: Int?
    var perPage: Int?
}
