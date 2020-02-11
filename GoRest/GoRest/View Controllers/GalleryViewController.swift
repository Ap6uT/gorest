//
//  GalleryViewController.swift
//  GoRest
//
//  Created by Alexander Grishin on 07.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

private let reuseIdentifier = "GalleryCell"

class GalleryViewController: UICollectionViewController {


    private let itemsPerRow: CGFloat = 3
    
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 1.0, bottom: 0.0, right: 0.0)
    
    
    var gallery = Gallery()

    override func viewDidLoad() {
        super.viewDidLoad()

        gallery.getGallery(completion: { success in
            self.collectionView.reloadData()
        })

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.content.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == gallery.content.count - 1 {
            let currentPage = gallery.currentPage
            let pageCount = gallery.pageCount
            if currentPage < pageCount && !gallery.isLoading {
                gallery.getGallery(completion: { success in
                    self.collectionView.reloadData()
                })
            }
            
        }
    }
    

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCell
        let imageID = gallery.content[indexPath.row].id
        let image = gallery.imageCache.object(forKey: imageID as AnyObject) as? UIImage
        cell.configure(image: image)
    
        return cell
    }
    


}


// MARK: - Collection View Flow Layout Delegate
extension GalleryViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
