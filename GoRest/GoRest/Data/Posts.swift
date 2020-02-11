//
//  Posts.swift
//  GoRest
//
//  Created by Alexander Grishin on 11.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class Posts {
    var content = [RestPost]()
    
    var rest = Rest.shared
    
    var comments: [String: Comments] = [:]
    
    var currentPage: Int {
        if let meta = meta {
            return meta.currentPage ?? 0
        }
        return 0
    }
    
    var pageCount: Int {
        if let meta = meta {
            return meta.pageCount ?? 0
        }
        return 0
    }
    
    var isLoading = false
    
    var meta: Meta?
    
    func getPosts(completion: @escaping SearchComplite) {
        if meta == nil || currentPage < pageCount {
            isLoading = true
            let nextPage = currentPage + 1
            rest.posts(forPage: nextPage, success: { meta, data in
                self.meta = meta
                self.content += data
                completion(true)
                self.isLoading = false
            }, failure: { error in
                print(error)
                self.isLoading = false
            })
        }
    }
    
}
