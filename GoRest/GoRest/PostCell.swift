//
//  PostCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postCommentsButton: UIButton!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //downloadTask?.cancel()
        //downloadTask = nil
    }
    
    func configure(for data: PostData, user: UserData?) {
        postTitleLabel.text = data.title ?? "title"
        postTextLabel.text = data.text ?? "post's text"
        if let user = user, let avatarArray = user.links, let avatarHref = avatarArray.avatar, let avatarString = avatarHref.link {
            if let avatarURL = URL(string: avatarString) {
                downloadTask = postImageView.loadImage(url: avatarURL)
            }
        }
        
    }
}
