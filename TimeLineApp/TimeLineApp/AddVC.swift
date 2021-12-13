//
//  AddVC.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 11/12/2021.
//

import UIKit
import Firebase

class AddVC: UIViewController {
    
    @IBOutlet weak var postField: UITextView!
    
    let db = Firestore.firestore()
    let userName = Auth.auth().currentUser?.displayName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func addPost(_ sender: Any) {
        db.collection("Posts").addDocument(data: [
            "userName" : userName,
            "post": postField.text!,
            "userImage": ""
        ]) { (err) in
            if err == nil {
                print("new doc created")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "barId") as! UITabBarController
                //                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            } else {
                print("error!")
                
            }
        }
        
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "barId") as! UITabBarController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    
}

