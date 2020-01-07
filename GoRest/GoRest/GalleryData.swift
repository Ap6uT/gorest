//
//  GalleryData.swift
//  GoRest
//
//  Created by Alexander Grishin on 26.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class GalleryDataArray: Codable {
    var meta = MetaData()
    var result = [GalleryData]()
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case result
    }
}

class GalleryData: Codable {
    
    var url: String?
    var id: String?

}
