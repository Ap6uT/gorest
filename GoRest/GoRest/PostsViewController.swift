//
//  PostsViewController.swift
//  GoRest
//
//  Created by Alexander Grishin on 10.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit

typealias SearchComplite = (Bool) -> Void

class PostsViewController: UITableViewController {
    
    var posts = Posts()
    var users = Users()
    
    var rest = Rest.shared
    var testUsers = [RestUser]()
    
    var content = [RestPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let errorClosure: Rest.FailureHandler = { error in
            print("***** error")
            print(error)
        }
        
        let successClosure: Rest.SuccessHandler<RestUser> = { meta, data in
            print("***** data")
            //print(data)
            self.testUsers.append(data)
            print(self.testUsers.count)
        }
        
        let successPostClosure: Rest.SuccessHandler<[RestPost]> = { meta, data in
            print("***** data")
            //if let array = data.array {
                self.content += data
            
            print(self.content.count)
        }
        
        
        //let successAddCommentClosure: Rest.SuccessHandler<RestComment> = { _ in
            
        //}
        
        //rest.request("users/123", method: .get, parameters: [:], success: successClosure, failure: errorClosure)
        
        
        //rest.request("posts", method: .get, parameters: [:], success: successPostClosure, failure: errorClosure)
        
        rest.posts(forPage: 2, success: successPostClosure, failure: errorClosure)
        
        //rest.addComment(for: "3", text: "test comment", success: nil, failure: nil)
        
        posts.getPosts(forPage: 1, completion: { success in
            self.tableView.reloadData()
            for post in self.posts.content {
                if let userID = post.userID {
                    if self.users.records[userID] == nil {
                        
                        self.users.getUser(for: userID, completion: { success in
                            self.tableView.reloadData()
                        })
                    }
                }

            }
        })
    }
    
    deinit {
        print("******* deinit view")
    }
    
    
    
    
    

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.content.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = posts.content[indexPath.row]
        let userID = post.userID ?? "0"
        
        let image = users.imageCache.object(forKey: userID as AnyObject) as? UIImage
        cell.configure(for: post, user: users.records[userID], image: image)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == posts.content.count - 1 {
            let currentPage = posts.currentPage
            let pageCount = posts.pageCount
            if currentPage < pageCount && !posts.isLoading {
                posts.getPosts(forPage: currentPage + 1, completion: { success in
                    self.tableView.reloadData()
                })
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPost", sender: indexPath)
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPost" {
            let controller = segue.destination as! PostDetailViewController
            let indexPath = sender as! IndexPath
            let post = posts.content[indexPath.row]
            controller.post = post
            if let userId = post.userID {
                controller.user = users.records[userId]
                controller.image = users.imageCache.object(forKey: userId as AnyObject) as? UIImage
            }
        }
    }
    

}
