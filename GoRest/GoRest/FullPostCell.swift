//
//  FullPostCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 09.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

class FullPostCell: UITableViewCell {
    
    @IBOutlet private weak var postTitleLabel: UILabel!
    @IBOutlet private weak var postTextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for post: PostData?) {
        if let post = post {
            postTitleLabel.text = post.title ?? ""
            postTextLabel.text = post.text ?? ""
        }
    }
}
