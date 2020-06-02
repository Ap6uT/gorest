//
//  GalleryCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 07.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

class GalleryCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
       super.awakeFromNib()
   }
   
   override func prepareForReuse() {
       super.prepareForReuse()
       downloadTask?.cancel()
       downloadTask = nil
   }
    
    func configure(imageURL: String?) {
        downloadTask = imageView.loadImage(urlString: imageURL)
    }
}
