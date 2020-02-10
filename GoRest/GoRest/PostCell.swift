//
//  PostCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet private weak var postImageView: UIImageView!
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postTextLabel: UILabel!
    @IBOutlet private weak var postCommentsButton: UIButton!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(for data: RestPost, user: RestUser?, image: UIImage?) {
        postTitleLabel.text = data.title ?? "title"
        postTextLabel.text = data.text ?? "post's text"
        
        let buttonTitle = "Comments: \(data.postID ?? "0")"
        postCommentsButton.setTitle(buttonTitle, for: .normal)
        if let image = image {
            postImageView.image = image
        }
    }
}
