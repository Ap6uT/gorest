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
    
    
    override func awakeFromNib() {
       super.awakeFromNib()
   }
   
   override func prepareForReuse() {
       super.prepareForReuse()
   }
    
    func configure(image: UIImage?) {

        if let image = image {
            imageView.image = image
        }
    }
}
