//
//  AddCommentViewController.swift
//  GoRest
//
//  Created by Alexander Grishin on 13.01.2020.
//  Copyright © 2020 Alexander Grishin. All rights reserved.
//

import UIKit

class AddCommentViewController: UIViewController {
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    var postID: String!
    
    let rest = Rest.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        if postID == "" {
            dismiss(animated: true, completion: nil)
        }
        commentTextView.becomeFirstResponder()
    }
    
    @IBAction func sendComment(_ sender: Any) {
        let text = commentTextView.text!
        if text != "" {
            rest.addComment(for: postID, text: text, success: nil, failure: {error in
                print(error)
            })
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelComment(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}
