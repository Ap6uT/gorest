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
    
    var currentPage: Int = 1
    var pageCount: Int = 0
    
    var isLoading =  false
    
    
    func getPosts(forPage page: Int, completion: @escaping SearchComplite) {
        var success = false
        //dataTask?.cancel()
        isLoading = true
        var dataTask: URLSessionDataTask?
        let url = postsURL(for: page)
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                print("post - 999")
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                if ErrorsData.parseErrors(data: data) == 200 {
                    let responseData = self.parsePosts(data: data)
                    let results = responseData.result
                    let meta = responseData.meta
                    self.pageCount = meta.pageCount ?? 0
                    self.currentPage = meta.currentPage ?? 1
                    self.content += results
                    success = true
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
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
            print("****** post '\(String(decoding: data, as: UTF8.self))'")
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
