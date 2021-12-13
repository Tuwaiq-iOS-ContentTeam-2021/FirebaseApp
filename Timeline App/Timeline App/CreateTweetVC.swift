//
//  CreateTweetVC.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase
class CreateTweetVC: UIViewController {
    
    @IBOutlet weak var postBtn: UIButton!
    
   
    @IBOutlet weak var tweetView: UITextView!

    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postBtn.layer.cornerRadius = 15
    }
    
    
    @IBAction func CreatePostClicked(_ sender: Any) {
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
//        let date = Date()
        print("myTime", myTimeInterval)
        
               db.collection("Users")
                   .document().setData(
                       [
                           "id"   : Auth.auth().currentUser!.uid,
                           "post" : tweetView.text!,
                           "date" : "\(myTimeInterval)",
                           "Auther": mainName
                           
                           
                       ])
               {(error) in
                   
                   if error == nil {
                   
                       print("Added Successfully")
                   
                   }else {
                   
                       print(error!.localizedDescription)
                   
                   }
                   
               }
        
    }
    


}
