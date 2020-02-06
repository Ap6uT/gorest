//
//  Rest+Post.swift
//  GoRest
//
//  Created by Alexander Grishin on 05.02.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation

extension Rest {
    public func posts <T: Codable>(forPage page: Int, success: SuccessHandler<T>?, failure: FailureHandler?) {
        request("posts", parameters: ["page":"\(page)"], success: success, failure: failure)
    }
}
