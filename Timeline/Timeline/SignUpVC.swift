//
//  SignUpVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameL: UILabel!
    
    @IBOutlet weak var emailL: UILabel!
    
    @IBOutlet weak var passwordL: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.placeholder = "Name"
        emailTF.placeholder = "Email"
        passwordTF.placeholder = "Password"
    }
    
    @IBAction func signUP(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) {
            user, error in
            if error == nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = self.nameTF.text
                changeRequest?.commitChanges { (error) in
                    if error == nil {
                        print("displayName done")
                        print(Auth.auth().currentUser?.displayName)
                    }else{
                        print(error)
                    }
                    
                    self.performSegue(withIdentifier: "next", sender: nil) }
            }else{
                print("error",error?.localizedDescription)
            }
        }
        
        
        
    }
    
    
}
