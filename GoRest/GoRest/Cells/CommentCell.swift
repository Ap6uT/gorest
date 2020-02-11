//
//  CommentCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 09.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet private weak var commentTextLabel: UILabel!
    @IBOutlet private weak var commentAuthorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for comment: RestComment) {

        commentTextLabel.text = comment.body ?? ""
        commentAuthorLabel.text = comment.name ?? ""
        
    }

}
