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
                
                let results = self.parsePosts(data: data)
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
    
    private func parsePosts(data: Data) -> [PostData] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(PostDataArray.self, from: data)
            return result.result
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
    private func postsURL(for page: Int) -> URL {
        let urlString = "https://gorest.co.in/public-api/posts?_format=json&access-token=" + tokenRestAPI + "&page=\(page)"
        let url = URL(string: urlString)
        return url!
    }
}
