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
    
    var postsArray = [PostData]()
    var usersArray: [String: UserData] = [:]
    
    let tokenRestAPI: String = "1pv2cjShsXhLvUa4IQhtzFoGjgUb-WSrRxIQ"
    
    private var dataTask: URLSessionDataTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts(forPage: 1, completion: { success in
            self.tableView.reloadData()
        })
        //getUser(for: "66", completion: { success in
        //    self.tableView.reloadData()
        //})
    }
    
    
    func getPosts(forPage page: Int, completion: @escaping SearchComplite) {
        var success = false
        dataTask?.cancel()
        let url = postsURL(for: page)
        let session = URLSession.shared
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                
                let results = self.parsePosts(data: data)
                self.postsArray += results
                success = true
                
                for post in self.postsArray {
                    if let userID = post.userID {
                        if self.usersArray[userID] == nil {
                            
                            self.getUser(for: userID, completion: completion)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
    func getUser(for id: String, completion: @escaping SearchComplite) {
        var success = false
        //usersTask?.cancel()
        var usersTask: URLSessionDataTask?
        let url = userURL(for: id)
        let session = URLSession.shared
        usersTask = session.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error as NSError?, error.code == -999 {
                return
            }
            if let httpReesponse = response as? HTTPURLResponse, httpReesponse.statusCode == 200, let data = data {
                if let results = self.parseUser(data: data) {
                    self.usersArray[id] = results
                }
                success = true
            }
            DispatchQueue.main.async {
                completion(success)
            }
        })
        usersTask?.resume()
    }
    
    func postsURL(for page: Int) -> URL {
        let urlString = "https://gorest.co.in/public-api/posts?_format=json&access-token=" + tokenRestAPI + "&page=\(page)"
        let url = URL(string: urlString)
        return url!
    }
    
    func userURL(for id: String) -> URL {
        let urlString = "https://gorest.co.in/public-api/users/\(id)?_format=json&access-token=" + tokenRestAPI
        let url = URL(string: urlString)
        return url!
    }
    
    func parsePosts(data: Data) -> [PostData] {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(PostDataArray.self, from: data)
            return result.result
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
    func parseUser(data: Data) -> UserData? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(UserDataArray.self, from: data)
            return result.result
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell

        let post = postsArray[indexPath.row]
        let userId = post.userID ?? "0"
        
        
        cell.configure(for: post, user: usersArray[userId])

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRow = indexPath.row
        if lastRow == postsArray.count - 1 {
            getPosts(forPage: postsArray.count / 20 + 1, completion: { success in
                self.tableView.reloadData()
            })
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
