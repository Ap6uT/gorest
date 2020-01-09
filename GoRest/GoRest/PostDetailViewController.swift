//
//  PostDetailViewController.swift
//  GoRest
//
//  Created by Alexander Grishin on 11.12.2019.
//  Copyright © 2019 Alexander Grishin. All rights reserved.
//

import UIKit

class PostDetailViewController: UITableViewController {
    
    
    struct TableView {
        struct CellIdentifiers {
            static let commentCell = "CommentCell"
            static let addCommentCell = "AddCommentCell"
            static let fullPostCell = "FullPostCell"
            static let authorCell = "AuthorCell"
        }
    }
    
    var post: PostData?
    var user: UserData?
    var image: UIImage?
    var comments = Comments()


    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.commentCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.commentCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.addCommentCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.addCommentCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.fullPostCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.fullPostCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.authorCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.authorCell)
        
        
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.content.count + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
           let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.authorCell, for: indexPath) as! AuthorCell
           cell.configure(for: user, withImage: image)
           return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.fullPostCell, for: indexPath) as! FullPostCell
            cell.configure(for: post)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.addCommentCell, for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.commentCell, for: indexPath) as! CommentCell
            let comment = comments.content[indexPath.row - 3]
            cell.configure(for: comment)
            return cell
        }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
