//
//  Rest+User.swift
//  GoRest
//
//  Created by Alexander Grishin on 05.02.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


extension Rest {
    public func user <T: Codable>(forId id: String, success: SuccessHandler<T>?, failure: FailureHandler?) {
        request("user/\(id)", success: success, failure: failure)
    }
}
