

import UIKit
import Firebase

class PostList: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let nc = NotificationCenter.default
//        nc.addObserver(self, selector: #selector(postsChanged(_:)), name: Post.PostsChangedNotification, object: nil)
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? Post else { return Post() }
        
//        cell.post = posts[indexPath.row]
        
        return cell
    }
    @objc func postsChanged(_ notification: Notification) {
        tableView.reloadData()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toPostDetail" {
//
//            if let detailViewController = segue.destination as? PostDetailTableViewController,
//                let selectedIndexPath = self.tableView.indexPathForSelectedRow {
//
//                let posts = PostController.sharedController.posts
//                detailViewController.post = posts[selectedIndexPath.row]
//            }
//        }
//
//        if segue.identifier == "toPostDetailFromSearch" {
//            if let detailViewController = segue.destination as? PostDetailTableViewController,
//                let sender = sender as? PostTableViewCell,
//                let selectedIndexPath = (searchController?.searchResultsController as? SearchResultsTableViewController)?.tableView.indexPath(for: sender),
//                let searchTerm = searchController?.searchBar.text?.lowercased() {
//
//                let posts = PostController.sharedController.posts.filter({ $0.matches(searchTerm: searchTerm) })
//                let post = posts[selectedIndexPath.row]
//
//                detailViewController.post = post
//            }
//        }
//    }

}
