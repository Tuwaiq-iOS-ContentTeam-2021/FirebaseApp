//
//  addTweetVC.swift
//  timeLineApp
//
//  Created by Areej on 12/12/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class addTweetVC: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var txtToPost: UITextView!
    @IBOutlet weak var imgToPost: UIImageView!
    let name = Auth.auth().currentUser?.displayName
    let email = Auth.auth().currentUser?.email
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func chooseimgToPost(_ sender: Any) {
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        db.collection("tweets").addDocument(data: [ "username" : name!,
                                                    "text" : txtToPost.text!,
                                                    "emailaccount" : email!
                                                  ]
        )
        { (err) in
            if let error = err{
                print(error.localizedDescription)
            }else {
               print("added")
            
                
            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "backToTimeline") as! timeLineVC
            self.present(vc, animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
            }
        }
        }

