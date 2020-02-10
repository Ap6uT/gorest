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
    
    /*func getComments(for post: String, page: Int, completion: @escaping SearchComplite) {
        var success = false
        isLoading = true
        dataTask?.cancel()
        let url = commentsURL(for: post, page: page)
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                
                let responseData = self.parseComments(data: data)
                let results = responseData.result
                let meta = responseData.meta
                self.pageCount = meta.pageCount ?? 0
                self.currentPage = meta.currentPage ?? 1
                self.totalCount = meta.totalCount ?? 0
                self.content += results
                success = true
            }
            DispatchQueue.main.async {
                self.isLoading = false
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
    // MARK: - Private Methods
    
    private func parseComments(data: Data) -> CommentsDataArray {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(CommentsDataArray.self, from: data)
            return result
        } catch {
            print("****** comment '\(String(decoding: data, as: UTF8.self))'")
            print("JSON Error: \(error)")
            return CommentsDataArray()
        }
    }
    
    private func commentsURL(for post: String, page: Int) -> URL {
        let urlString = "https://gorest.co.in/public-api/comments?_format=json&access-token=" + tokenRestAPI + "&post_id=\(post)" + "&page=\(page)"
        let url = URL(string: urlString)
        return url!
    }*/
    
}
