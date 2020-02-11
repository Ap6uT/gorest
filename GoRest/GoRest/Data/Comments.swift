//
//  Comments.swift
//  GoRest
//
//  Created by Alexander Grishin on 12.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation


class Comments {
    let rest = Rest.shared
    
    var content = [RestComment]()
    
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
    
    var totalCount: Int {
        if let meta = meta {
            return meta.totalCount ?? 0
        }
        return 0
    }
    
    var meta: Meta?
    
    var isLoading =  false
    private var dataTask: URLSessionDataTask?
    
    
    func getComments(for post: String, completion: @escaping SearchComplite) {
        if meta == nil || currentPage < pageCount {
            isLoading = true
            let nextPage = currentPage + 1
            rest.comments(for: post, page: nextPage, success: { meta, data in
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
