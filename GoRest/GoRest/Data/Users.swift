//
//  Users.swift
//  GoRest
//
//  Created by Alexander Grishin on 11.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit


class Users {
    
    private var dataTask: URLSessionDataTask?
    private var imageTask: URLSessionDownloadTask?
    
    let rest = Rest.shared
    
    var records: [String: RestUser] = [:]
    
    var meta: Meta?
        
    func getUser(for id: String, completion: @escaping SearchComplite) {
        rest.user(forId: id, success: { meta, data in
            self.meta = meta
            self.records[id] = data
            completion(true)
        }, failure: { error in
            print(error)
        })
    }
    
    

    
}
