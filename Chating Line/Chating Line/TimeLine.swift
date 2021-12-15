//
//  TimeLine.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 07/05/1443 AH.
//

import UIKit
import SwiftUI
import Firebase


class TimeLine: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let firestoreURL = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    var arrUser:[Users] = []
    @IBOutlet weak var timeLine: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserFromfirestore()
        self.timeLine.reloadData()
        
    }
    
    
    func getUserFromfirestore(){
        firestoreURL.collection("Post")
            .order(by: "date")
            .getDocuments { querySnapshot, err in
            if let err = err {
                print("error get document: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("=========")
                    let data = document.data()
                    print(document.data())
                    self.arrUser.append(Users( email: data["uemail"] as? String ?? ""  , post: (data["post"] as? String) ))
                    self.timeLine.reloadData()
                }
                
            }
        }
        
    }
    
}



extension TimeLine {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUser.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = timeLine.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! TimeLineCell
        
        cell.labelEmail.text = arrUser[indexPath.row].email
        cell.labelDesc.text = arrUser[indexPath.row].post
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}


