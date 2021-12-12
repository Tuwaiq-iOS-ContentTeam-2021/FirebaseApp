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
    var arr:[Users] = []
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewTM.delegate = self
        tableViewTM.dataSource = self
        getUserFromFB()
        getData()
    }
    func getUserFromFB() {
        db.collection("Users").getDocuments { SnapShot, error in
            for id in SnapShot!.documents {
                print("_______________")
                print("ID: \(id.documentID)")
                self.arr.append(Users(name: id.get("name") as! String, username: id.get("username") as! String, email: id.get("email") as! String))
            }
            self.tableViewTM.reloadData()
        }
    }
    
    func getData() {
        db.collection("Users")
            .whereField("ID", isEqualTo: user?.uid)
            .getDocuments(
                completion: {
                    (qurySnapShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnapShot!.documents {
                            let data = document.data()
                            print(data["name"] as? String ?? "value not found")
//                            let dataName = data["name"] as? String ?? "value not found"
                            
                        }
                    }
                }
            )
    }

}

extension TimeLineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TimeLineTableViewCell
        cell.nameLabel.text =
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}
struct Users {
    var name : String
    var username : String
    var email : String
}
