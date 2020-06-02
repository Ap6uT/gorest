//
//  Gallery.swift
//  GoRest
//
//  Created by Alexander Grishin on 26.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit


class Gallery {
    
    let rest = Rest.shared
    
    var meta: Meta?
    
    private var dataTask: URLSessionDataTask?
    private var imageTask: URLSessionDownloadTask?
    
    //var records: [String: RestGallery] = [:]

    
    var content = [RestGallery]()
    
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
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var isLoading =  false
    
    func getGallery(completion: @escaping SearchComplite) {
        if meta == nil || currentPage < pageCount {
            isLoading = true
            let nextPage = currentPage + 1
            rest.gallery(forPage: nextPage, success: { meta, data in
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
