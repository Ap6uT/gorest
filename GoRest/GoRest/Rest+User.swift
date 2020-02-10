//
//  Rest+User.swift
//  GoRest
//
//  Created by Alexander Grishin on 05.02.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


extension Rest {
    public func user(forId id: String, success: SuccessHandler<RestUser>?, failure: FailureHandler?) {
        request("users/\(id)", success: success, failure: failure)
    }
}
