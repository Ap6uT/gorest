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
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)

    
    var gallery = Gallery()

    override func viewDidLoad() {
        super.viewDidLoad()
        gallery.getGallery(for: 1, completion: { success in
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
                gallery.getGallery(for: currentPage + 1, completion: { success in
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
    


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
