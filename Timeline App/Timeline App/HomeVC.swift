//
//  HomeVC.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/11/21.
//

import UIKit
import Firebase
class HomeVC: UIViewController {
    //MARK: - Properties
    let db = Firestore.firestore()
    let email = Auth.auth().currentUser!.email
    var arrayTweet: [Tweet] = []
    let newPostButton = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getTweet()
        title = "Home"
        //MARK: - TableView
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "PostCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "CellID")
        tableView.frame = CGRect(x: 15, y: 40, width: 398, height: 800)
        view.addSubview(tableView)
        //MARK: - NewPostButton
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        newPostButton.frame = CGRect(x: 315, y: 740, width: 100 , height: 100)
        newPostButton.tintColor = #colorLiteral(red: 0.867621541, green: 0.1653445661, blue: 0.2664638758, alpha: 1)
        newPostButton.setImage(largeBoldPost, for: .normal)
        newPostButton.addTarget(self, action: #selector(newPost), for: .touchUpInside)
        view.addSubview(newPostButton)
    }
    //MARK: - Methods
    @objc func newPost(){
        var textField = UITextField()
        let alert = UIAlertController(title: "Alert", message: "Add new tweet", preferredStyle: .alert)
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Add your tweet"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Post", style: .default) { action in
            
            self.db.collection("Posts")
                .addDocument(data:
                                [
                                    "post" : textField.text!,
                                    "email": self.email!,
                                    "time": FieldValue.serverTimestamp()
                                ])
            { error in
                if error == nil {
                    print("New document has been created...")
                    
                    
                    let email = self.email!
                    let tweet = textField.text!
                    
                    let tweets = Tweet(email: email, tweet: tweet)
                    self.arrayTweet.append(tweets)
                    self.arrayTweet.reverse()
                    self.tableView.reloadData()
                } else {
                    print("error\(error!.localizedDescription)")
                }
                
            }
        }
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func getTweet() {
        db.collection("Posts")
            .order(by: "time")
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
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
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
