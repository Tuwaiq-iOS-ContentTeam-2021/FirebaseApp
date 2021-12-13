//
//  PostVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/11/21.
//

import UIKit
import Firebase
class PostVC: UIViewController {
    //MARK: - Properties
    let db = Firestore.firestore()
    let email = Auth.auth().currentUser!.email!
    var arrayTweet: [Tweet] = []
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "My Post"
        getTweet()
        //MARK: - TableView
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CellID")
        tableView.frame = CGRect(x: 15, y: 40, width: 398, height: 800)
        view.addSubview(tableView)
        
    }
    //MARK: - Methods
    func getTweet() {
        db.collection("Posts").whereField("email", isEqualTo: self.email)
            .getDocuments { querySnapshot, error in
                
                if error == nil {
                    
                    for doc in querySnapshot!.documents {
                        
                        let email = doc.get("email") as! String
                        let tweet = doc.get("post") as! String
                        
                        let tweets = Tweet(email: email, tweet: tweet)
                        self.arrayTweet.append(tweets)
                        
                    }
                    self.arrayTweet.reverse()
                    self.tableView.reloadData()
                } else {
                    print(error!.localizedDescription)
                }
            }
        
    }
    
    
}
// MARK: - Extensions
extension PostVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayTweet.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID") as! PostCell
        cell.emailLabel.text = arrayTweet[indexPath.row].email
        cell.tweetTextView.text = arrayTweet[indexPath.row].tweet
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}


