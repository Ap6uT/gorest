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
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
            posts.getPosts(forPage: posts.content.count / 20 + 1, completion: { success in
                self.tableView.reloadData()
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPost", sender: indexPath)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
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
