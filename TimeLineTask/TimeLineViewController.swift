//
//  TimeLineViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit
import Firebase
import CloudKit

class TimeLineViewController: UIViewController {

    
    @IBOutlet weak var tableViewTM: UITableView!
//    var arr:[Users] = []
    var timeLiners:[timeLine] = []
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewTM.delegate = self
        tableViewTM.dataSource = self
        getContent()
        tableViewTM.reloadData()
        
    }
    func getContent() {
        db.collection("Content")
//            .order(by: "time", descending: true)
            .getDocuments(
                completion: {
                    (qurySnapShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnapShot!.documents {
                            let dataSender = document.get("sender")! as! String
                               let dataContent = document.get("content")! as! String
                            let dataUsername = document.get("username")! as! String
                            
                                let newContent = timeLine(sender: dataSender, username: dataUsername, content: dataContent)
                                self.timeLiners.append(newContent)
                        }
                        self.tableViewTM.reloadData()
                    }
                }
            )
    }

    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "test", sender: self)
    }
    
}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeLiners.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TimeLineTableViewCell
        cell.userNameLabel.text = timeLiners[indexPath.row].sender
//        self.sendName = timeLiners[indexPath.row].sender
        cell.thePostLabel.text = timeLiners[indexPath.row].content
//        self.sendUser = timeLiners[indexPath.row].content

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
struct Users {
    var name : String
    var username : String
    var email : String
}
