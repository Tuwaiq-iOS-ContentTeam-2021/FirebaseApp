//
//  PostVC.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 11/12/2021.
//

import UIKit
import Firebase

class PostVC: UIViewController {

    let db = Firestore.firestore()
    @IBOutlet weak var descrabtionTextFiled: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func postAcation(_ sender: Any) {
        
        db.collection("users").addDocument(data: [
            "userName" : Auth.auth().currentUser?.email,
            "descrabtion" : descrabtionTextFiled.text!,
            "Date" : FieldValue.serverTimestamp()
            
            
           
        ])
        { err in
            if err == nil {
                print("new document has been created....:")
            } else {
                print(err?.localizedDescription)
            }


        }

        
        
    }
    

}
