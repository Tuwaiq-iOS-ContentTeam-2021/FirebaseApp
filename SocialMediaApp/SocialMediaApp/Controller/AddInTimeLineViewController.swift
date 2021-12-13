//
//  AddInTimeLineViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit
import Firebase
class AddInTimeLineViewController: UIViewController{
    
    @IBOutlet var addTweetButtonOutlet: UIButton!
    let db = Firestore.firestore()
    let currerntUID = Auth.auth().currentUser!.uid
    let currerntEmail = Auth.auth().currentUser!.email
    
    
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTweetButtonOutlet.layer.cornerRadius = 15
        
        
    }
      
    
    @IBAction func addActionButton(_ sender: Any) {
        
        self.db.collection("tweets")
            .document()
            .setData([
                "email" : Auth.auth().currentUser!.email!  ,
                "tweetContent" : contentTextView.text ?? "" ,
                "timeStamp" : FieldValue.serverTimestamp()
        ])
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
