//
//  NewPostVC.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class NewPostVC: UIViewController {
    
    let db = Firestore.firestore()
    
    var name : String = ""
    
    @IBOutlet weak var textArea: UITextView!
    
    @IBOutlet weak var postButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        
        textArea.layer.cornerRadius = 15
        textArea.layer.borderWidth = 0.2
        
        postButtonOutlet.layer.cornerRadius = 15
    }
    
    @IBAction func postAction(_ sender: Any) {
        
        if textArea.text.isEmpty {
            
            let alert = UIAlertController(title: "Alert", message: "There is nothing to share!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            
        }else {
            sendNewPost()
            textArea.text = ""
        }
        
    }
    
    func sendNewPost(){
        
        db.collection("Posts")
            .document().setData(
                [
                    "id"   : Auth.auth().currentUser?.uid,
                    "post" : textArea.text!,
                    "name" : self.name ,
                    "date" : FieldValue.serverTimestamp()
                    
                ])
        {(error) in
            if error == nil {
                print("Added Successfully")
            }else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func getUserData(){
        
        let email = Auth.auth().currentUser!.email!
        
        
        db.collection("Users").document().parent.whereField("email", isEqualTo: email).getDocuments { QuerySnapshot, Error in
            
            if Error == nil {
                
                self.name = QuerySnapshot?.documents[0].get("name") as! String
                
            }else{
                print(Error!.localizedDescription)
            }
        }
    }
}

