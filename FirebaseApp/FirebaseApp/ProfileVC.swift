//
//  ProfileVC.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class ProfileVC: UIViewController {
    let db = Firestore.firestore()
    
    @IBOutlet weak var photoOfUser: UIImageView!
    
    @IBOutlet weak var nameUser: UILabel!
    
    @IBOutlet weak var emailUser: UILabel!
    
    @IBOutlet weak var buttonLogOutOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailUser.text = Auth.auth().currentUser?.email
        
        getUserData()
        
        buttonLogOutOutlet.layer.cornerRadius = 15
        
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Log Out", message: "Are you sure to log Out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Logout", comment: "Default action"), style: .default , handler: { UIAlertAction in
            
            do {
                try Auth.auth().signOut()
                
                self.dismiss(animated: true, completion: nil)
                
            }catch{
                print(error.localizedDescription)
            }
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    func getUserData(){
        
        let email = Auth.auth().currentUser!.email!
        
        db.collection("Users").document().parent.whereField("email", isEqualTo: email).getDocuments { QuerySnapshot, Error in
            
            
            if Error == nil {
                
                self.nameUser.text = QuerySnapshot?.documents[0].get("name") as? String
                
            }else{
                print(Error!.localizedDescription)
            }
        }
    }
}

