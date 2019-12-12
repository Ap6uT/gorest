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
    
    
    var records: [String: UserData] = [:]
    var images: [String: UIImage] = [:]
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getUser(for id: String, completion: @escaping SearchComplite) {
        var success = false
        //usersTask?.cancel()
        var usersTask: URLSessionDataTask?
        let url = userURL(for: id)
        let session = URLSession.shared
        usersTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                print("user - 999")
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                if let results = self.parseUser(data: data) {
                    self.records[id] = results
                }
                success = true
            }
            DispatchQueue.main.async {
                completion(success)
                //if self.images[id] == nil {
                if self.imageCache.object(forKey: id as AnyObject) == nil {
                    if let urlString = self.records[id]?.links.avatar.link, let url = URL(string: urlString) {
                        var imageTask: URLSessionDownloadTask?
                        imageTask = self.loadImage(url: url, userID: id)
                    }
                }
            }
        })
        usersTask?.resume()
    }
    
    // MARK: - Private Methods
    
    func loadImage(url: URL, userID id: String) -> URLSessionDownloadTask {
        let session = URLSession.shared
        let downloadTask = session.downloadTask(with: url, completionHandler: { [weak self] url, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if error == nil, let url = url, let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    if let weakSelf = self {
                        weakSelf.images[id] = image
                        weakSelf.imageCache.setObject(image, forKey: id as AnyObject)
                    }
                }
            }
        })
        downloadTask.resume()
        return downloadTask
    }
    
    private func userURL(for id: String) -> URL {
        let urlString = "https://gorest.co.in/public-api/users/\(id)?_format=json&access-token=" + tokenRestAPI
        let url = URL(string: urlString)
        return url!
    }
    
    
    private func parseUser(data: Data) -> UserData? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(UserDataArray.self, from: data)
            return result.result
        } catch {
            print("****** user '\(data)'")
            print("JSON Error: \(error)")
            return nil
        }
    }
}
