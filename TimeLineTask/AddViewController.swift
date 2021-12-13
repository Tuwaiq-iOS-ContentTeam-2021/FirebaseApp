//
//  AddViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit
import Firebase

class AddViewController: UIViewController {
    
    var timeLiners:[timeLine] = []
    let db = Firestore.firestore()
    var username = ""
    
    let user = Auth.auth().currentUser
    @IBOutlet weak var textArea: UITextView!
    let vc = TimeLineViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        tableTimeline.addSubview(refreshControl)
        
        
    }
    func addCollection() {
        self.db.collection("Content")
            .addDocument(data:
                            [
                                "id" : user?.uid,
                                "sender" : user?.email,
                                "content" : textArea.text,
                                "username" : username,
                                //                                "time" : Date().timeIntervalSince
                            ])
    }
    
    @IBAction func postButton(_ sender: Any) {
        addCollection()
        //        vc.tableViewTM.reloadData()
        //        let vc = storyboard?.instantiateViewController(withIdentifier: "wow") as! TimeLineViewController
        //        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        //        let vc = TimeLineViewController()
        //        present(vc, animated: true, completion: nil)
    }
}


struct timeLine {
    var sender : String
    var username : String
    var content : String
}
