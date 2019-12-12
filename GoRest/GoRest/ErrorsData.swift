//
//  ErrorsData.swift
//  GoRest
//
//  Created by Alexander Grishin on 12.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class ErrorsData: Codable {
    var meta = MetaData()
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
    }
    
    
    class func parseErrors(data: Data) -> Int {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ErrorsData.self, from: data)
            return result.meta.code ?? 0
        } catch {
            print("****** error '\(String(decoding: data, as: UTF8.self))'")
            print("JSON Error: \(error)")
            return 0
        }
    }
}
