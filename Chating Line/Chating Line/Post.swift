//
//  Post.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 07/05/1443 AH.
//

import UIKit
import Firebase


class Post: UIViewController {
    let firestoreURL = Firestore.firestore()
    let userId = Auth.auth().currentUser?.uid
    let useremail = Auth.auth().currentUser?.email
    @IBOutlet weak var tweetPost: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func postbutton(_ sender: Any) {
        
        firestoreURL.collection("Post")
            .addDocument(data: [
                "post" : tweetPost.text!,
                "userid" : userId,
                "uemail" : useremail,
                "date" : Date().timeIntervalSinceNow
            ])
        { (error) in
            if let e = error {
                print(e)
            } else {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "post") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
                print("Successfully saved data")
            }
        }
        
        
    }
    
}






