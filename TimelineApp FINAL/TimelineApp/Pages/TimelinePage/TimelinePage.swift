//
//  HomePage.swift
//  TimelineApp
//
//  Created by Mola on 11/12/2021.
//

import UIKit
import Firebase
class TimelinePage: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    var posts = [Post]()
    let db = Firestore.firestore() // refrence
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        loadPostFromFirebase()
        myTableView.reloadData()
        
        refreshControl.addTarget(self, action: #selector(self.getData(_:)),for: .valueChanged)
        myTableView.addSubview(refreshControl)
    }
    
    @objc func getData(_ sender: AnyObject) {
        posts.removeAll()
        loadPostFromFirebase()
        refreshControl.endRefreshing()
        }

    func loadPostFromFirebase(){

            db.collection("Post")
                .getDocuments(completion: {
                (querySnapshot, error) in

                self.posts = []
                if let error = error {
                  print(error.localizedDescription)
                }
                else{
                  for docuemnt in querySnapshot!.documents {
                    let email = docuemnt.get("email")! as! String
                    let words = docuemnt.get("words")! as! String
                      let aPost = Post(email: email, words: words)
                    self.posts.append(aPost)
                  }
                  self.myTableView.reloadData()
                }
              })
          }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TimelineCell
        cell.email.text = posts[indexPath.row].email
        cell.words.text = posts[indexPath.row].words
        return cell
    }
    
}
