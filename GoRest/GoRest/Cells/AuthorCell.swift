//
//  AuthorCell.swift
//  GoRest
//
//  Created by Alexander Grishin on 09.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

class AuthorCell: UITableViewCell {
    
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userSiteLabel: UILabel!
    @IBOutlet private weak var userStatusLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for user: RestUser?, withImage image: UIImage?) {
        if let user = user {
            userNameLabel.text = "\(user.firstName ?? "User") \(user.lastName ?? "")"
            userSiteLabel.text = user.website ?? ""
            userStatusLabel.text = user.status ?? "inactive"
        }
        
        if let image = image {
            userImage.image = image
        }
    }

}
