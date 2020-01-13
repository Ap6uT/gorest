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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.clear
        if postID == "" {
            dismiss(animated: true, completion: nil)
        }
        commentTextView.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendComment(_ sender: Any) {
        postComment()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelComment(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func postComment() {
        let text = commentTextView.text!
        if text != "" {
            let url = URL(string: "https://gorest.co.in/public-api/comments")!
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
            components.queryItems = [
                URLQueryItem(name: "format", value: "json"),
                //URLQueryItem(name: "access-token", value: tokenRestAPI),
                URLQueryItem(name: "name", value: "Alexander Grishin"),
                URLQueryItem(name: "body", value: text),
                URLQueryItem(name: "post_id", value: postID),
                URLQueryItem(name: "email", value: "Yippee-ki-yay@mf.com"),
            ]

            let query = components.url!.query
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer " + tokenRestAPI, forHTTPHeaderField: "Authorization")
            //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = Data(query!.utf8)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
                        print ("data = \(jsonResponse)")
                    }catch _ {
                        print ("OOps not good JSON formatted response")
                    }
                }
            }
            task.resume()
        }
    }
}
