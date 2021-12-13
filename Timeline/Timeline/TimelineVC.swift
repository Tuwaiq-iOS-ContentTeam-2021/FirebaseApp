//
//  TimelineVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase




class TimelineVC: ViewController,UIApplicationDelegate,UITableViewDataSource, UITableViewDelegate{
    let db = Firestore.firestore()
    var user : [Users] = []
    let ID = Auth.auth().currentUser?.uid
    @IBOutlet weak var myTableview: UITableView!
    

    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableview.delegate = self
        myTableview.dataSource = self
        readdata()
        // Do any additional setup after loading the view.
   

}
    func readdata() {
                db.collection("Post")
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
        
                            for document in querySnapshot!.documents {
                                let data = document.data()
                               
                                self.user.append(Users(name: data["name"] as? String ?? "no name", id: self.ID ?? "no id", post: data["Post"]as? String ?? "no post"))
                                self.myTableview.reloadData()
                            }
        
                        }
                    }
    }

    
    
    
}



extension TimelineVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! timelineCell
        cell.username.text = user[indexPath.row].name
        cell.postlabel.text = user[indexPath.row].post
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
               return 300
           } else {
               return 230
           }
       }
    
    
}

