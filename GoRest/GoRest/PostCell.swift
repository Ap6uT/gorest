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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(for data: PostData) {
        postTitleLabel.text = (data.postID ?? "") + (data.title ?? "title")
        postTextLabel.text = data.text ?? "post's text"
    }
}
