//
//  Rest+Comments.swift
//  GoRest
//
//  Created by Alexander Grishin on 05.02.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import Foundation


extension Rest {
    public func comments(for post: String, page: Int, success: SuccessHandler<[RestComment]>?, failure: FailureHandler?) {
        request("comments", parameters: ["post_id":post, "page":"\(page)"], success: success, failure: failure)
    }
    
    
    public func addComment(for post: String, text: String, success: SuccessHandler<[RestComment]>?, failure: FailureHandler?) {
        
        var parameters = Parameters()
        
        parameters["name"] = "Alexander Grishin"
        parameters["body"] = text
        parameters["post_id"] = post
        parameters["email"] = "Yippee-ki-yay@mf.com"
        
        request("comments", method: .post, parameters: parameters, success: success, failure: failure)
    }
}
