//
//  Gallery.swift
//  GoRest
//
//  Created by Alexander Grishin on 26.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit


class Gallery {
    
    private var dataTask: URLSessionDataTask?
    private var imageTask: URLSessionDownloadTask?
    
    var records: [String: GalleryData] = [:]
    var images: [String: UIImage] = [:]
    
    var content = [GalleryData]()
    
    var currentPage: Int = 1
    var pageCount: Int = 0
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    var isLoading =  false
    
    func getGallery(for page: Int, completion: @escaping SearchComplite) {
        var success = false
        //usersTask?.cancel()
        var usersTask: URLSessionDataTask?
        isLoading = true
        let url = galleryURL(for: page)
        let session = URLSession.shared
        usersTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                print("user - 999")
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {

                if ErrorsData.parseErrors(data: data) == 200 {
                    let responseData = self.parseGallery(data: data)
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
                for item in self.content {
                    if let photoID = item.id {
                        if self.imageCache.object(forKey: photoID as AnyObject) == nil {
                            if let urlString = item.url, let url = URL(string: urlString) {
                                var imageTask: URLSessionDownloadTask?
                                imageTask = self.loadImage(url: url, photoID: photoID)
                            }
                        }
                    }
                }
            }
        })
        usersTask?.resume()
    }
    
    // MARK: - Private Methods
    
    func loadImage(url: URL, photoID id: String) -> URLSessionDownloadTask {
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
    
    private func galleryURL(for page: Int) -> URL {
        let urlString = "https://gorest.co.in/public-api/photos?_format=json&access-token=" + tokenRestAPI + "&page=\(page)"
        let url = URL(string: urlString)
        return url!
    }
    
    
    private func parseGallery(data: Data) -> GalleryDataArray {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(GalleryDataArray.self, from: data)
            return result
        } catch {
            print("****** user '\(data)'")
            print("JSON Error: \(error)")
            return GalleryDataArray()
        }
    }
    
}
