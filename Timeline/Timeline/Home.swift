//
//  Home.swift
//  Timeline
//
//  Created by Sahab Alharbi on 06/05/1443 AH.
//

import UIKit
import Firebase
class Home: UIViewController{
    
    
    
    
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    var tweetData: [Info] = []
    
    @IBOutlet weak var tweetsTV: UITableView!
    
    @IBOutlet weak var addtweetB: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetsTV.delegate = self
        tweetsTV.dataSource = self
        
        getData()
        
    }
    
    func getData() {
        firestore.collection("Tweets")
            .whereField("userid", isEqualTo: userID)
            .getDocuments(
                completion: {
                    (qurySnapShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnapShot!.documents {
                            let data = document.data()
                            
                            self.tweetData.append(Info(name:data["name"] as! String , tweet:data["tweet"] as! String ))
                            
                        }
                    }
                    self.tweetsTV.reloadData()
                }
            )
    }
    
    
    
}

struct Info {
    var name:String?
    var tweet:String?
    
    
    
    
}


extension Home: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetcell", for: indexPath) as! TweetCell
        cell.namelabel.text = tweetData[indexPath.row].name
        cell.tweetlabel.text = tweetData[indexPath.row].tweet
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
