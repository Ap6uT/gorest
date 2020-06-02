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
        
        posts.getPosts(completion: { success in
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
        
        cell.configure(for: post, user: users.records[userID])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == posts.content.count - 1 {
            let currentPage = posts.currentPage
            let pageCount = posts.pageCount
            if currentPage < pageCount && !posts.isLoading {
                posts.getPosts(completion: { success in
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
            }
        }
    }
    

}
