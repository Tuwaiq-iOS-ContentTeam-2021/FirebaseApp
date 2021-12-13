//
//  NewAccountVC.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class NewAccountVC: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createButtonOutlet.layer.cornerRadius = 15
    }
    
    @IBAction func createButton(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, Error in
            
            if Error == nil {
                self.db.collection("Users")
                    .document().setData(
                        [
                            "email" : self.emailTextField.text!,
                            "name" : self.nameTextField.text!
                        ])
                {(error) in
                    if error == nil {
                        print("Added Succ..")
                    }else {
                        print(error!.localizedDescription)
                    }
                }
                
                self.dismiss(animated: true, completion: nil)
                
                let alert = UIAlertController(title: "Congratulations!!", message: "Your account is ready , You can sign in", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: .none))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                let alert = UIAlertController(title: "Alert", message: Error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: .none))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
}

