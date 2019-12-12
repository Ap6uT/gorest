//
//  Posts.swift
//  GoRest
//
//  Created by Alexander Grishin on 11.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import Foundation

class Posts {
    var content = [PostData]()
    
    var comments: [String: Comments] = [:]
    
    var currentPage = 1
    var pageCount = 0
    
    
    private var dataTask: URLSessionDataTask?
    
    func getPosts(forPage page: Int, completion: @escaping SearchComplite) {
        var success = false
        dataTask?.cancel()
        let url = postsURL(for: page)
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                
                let responseData = self.parsePosts(data: data)
                let results = responseData.result
                if let meta = responseData.meta {
                    self.pageCount = meta.pageCount ?? 0
                    self.currentPage = meta.currentPage ?? 1
                }
                self.content += results
                success = true
            }
            DispatchQueue.main.async {
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
    // MARK: - Private Methods
    
    private func parsePosts(data: Data) -> PostDataArray {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(PostDataArray.self, from: data)
            return result
        } catch {
            print("JSON Error: \(error)")
            return PostDataArray()
        }
    }
    
    private func postsURL(for page: Int) -> URL {
        let urlString = "https://gorest.co.in/public-api/posts?_format=json&access-token=" + tokenRestAPI + "&page=\(page)"
        let url = URL(string: urlString)
        return url!
    }
}
