//
//  AddPostVC.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit
import Firebase
class AddPostVC: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var Posttext: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

  
    @IBAction func PostAction(_ sender: Any) {
        db.collection("post").document().setData(["emali": Auth.auth().currentUser?.email!,
        "post": Posttext.text!
    ]){
            error in
            if error == nil {
                print("انت ماشي صح")
            }
        }
    }
    
}
