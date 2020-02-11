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
    var images: [String: UIImage] = [:]
    
    var meta: Meta?
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    
    func getUser(for id: String, completion: @escaping SearchComplite) {
        rest.user(forId: id, success: { meta, data in
            self.meta = meta
            self.records[id] = data
            completion(true)
            if self.imageCache.object(forKey: id as AnyObject) == nil {
                if let urlString = self.records[id]?.links?.avatar?.link, let url = URL(string: urlString) {
                    var imageTask: URLSessionDownloadTask?
                    imageTask = self.loadImage(url: url, userID: id)
                }
            }
        }, failure: { error in
            print(error)
        })
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
    
}
