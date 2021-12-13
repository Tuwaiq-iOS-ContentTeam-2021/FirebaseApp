//
//  HomeVc.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 11/12/2021.
//

import UIKit
import Firebase

class HomeVc: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var timLine: UITableView!
    
    let db = Firestore.firestore()
    
    var posts: [Post] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timLine.delegate = self
        timLine.dataSource = self
        readData()
    }
    
    
    
    func readData() {
        db.collection("Posts").getDocuments { (post, error) in
            if let error = error {
                print("can't read data!!", error.localizedDescription)
            } else {
                for doc in post!.documents {
                    let data = doc.data()
                    print(data["userName"] as? String ?? "there is no userName!!")
                    print(data["post"] as? String ?? "there is no post!!")
                    
                    
                    self.posts.append(Post(username: data["userName"] as? String ?? "there is no userName!!", post: data["post"] as? String ?? "there is no post!!"))
                    
                    self.timLine.reloadData()
                }
            }
        }
    }
    
   
}

extension HomeVc {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timLine.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        
        cell.userName.text = posts[indexPath.row].username
        cell.userPost.text = posts[indexPath.row].post
        
        return cell
    }
    
    
}



struct Post {
    var username: String
    var post: String
}
