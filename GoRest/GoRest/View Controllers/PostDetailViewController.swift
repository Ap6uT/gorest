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
    
    var post: RestPost!
    var user: RestUser?
    var comments = Comments()

    private let customRefreshControl = UIRefreshControl()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if user == nil, let userID = post.userID {
            let users = Users()
            users.getUser(for: userID, completion: { success in
                if success {
                    self.user = users.records[userID]
                }
                self.tableView.reloadData()
            })
        }
        
        loadCleanComments()
        
        customRefreshControl.addTarget(self, action: #selector(loadComments(_:)), for: .valueChanged)
        tableView.refreshControl = customRefreshControl
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.commentCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.commentCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.addCommentCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.addCommentCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.fullPostCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.fullPostCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.authorCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.authorCell)
        
        
        
        
    }
    
    @objc private func loadComments(_ sender: Any) {
        loadCleanComments()
    }
    
    private func loadCleanComments() {
        comments.content.removeAll()
         if let postId = post.postID {
            comments.getComments(for: postId, completion: { success in
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.content.count + 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
           let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.authorCell, for: indexPath) as! AuthorCell
           cell.configure(for: user)
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.row == 2 {
            return indexPath
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "AddComment", sender: indexPath)
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == comments.content.count + 2 {
            let currentPage = comments.currentPage
            let pageCount = comments.pageCount
            if let post = post, let postId = post.postID {
                if currentPage < pageCount && !comments.isLoading {
                    comments.getComments(for: postId, completion: { success in
                        self.tableView.reloadData()
                    })
                }
            }
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddComment" {

            let detailViewController = segue.destination as! AddCommentViewController
            detailViewController.postID = post.postID ?? ""
        }
    }

}
