//
//  Rest+Gallery.swift
//  GoRest
//
//  Created by Alexander Grishin on 11.02.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation

extension Rest {
    public func gallery(forPage page: Int, success: SuccessHandler<[RestGallery]>?, failure: FailureHandler?) {
        request("photos", parameters: ["page":"\(page)"], success: success, failure: failure)
    }
}
