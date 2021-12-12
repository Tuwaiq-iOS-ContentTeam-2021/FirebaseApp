//
//  AddViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit
import Firebase

class AddViewController: UIViewController {

    var timeLiners = [timeLine]()
    let db = Firestore.firestore()
    var name = ""
    var username = ""
    var myId = ""
    
    @IBOutlet weak var textArea: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func sendMsg(){
        myId = Auth.auth().currentUser!.uid
        let messageData = ["sender": myId ,
                           "content" : textArea.text!,
                           "username": username]


        db.collection("Messages").addDocument(data: messageData) { error in
            if let error = error{
                print("erorrrr", error)
            }
            else{
                print("added")
            }
        }

    }
    
    @IBAction func postButton(_ sender: Any) {
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        // not working with dismiss, preset, performSegue, nor storyboardID...
    }
}


struct timeLine {
    var sender : String
    var username : String
    var content : String
}
