//
//  login vc.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTF.placeholder = "Email"
        passwordTF.placeholder = "Password"
        
    }
   
   
    @IBAction func forgetPassword(_ sender: Any) {
 
    

        
    }
    @IBAction func loginBu(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { user, error in
            if error == nil {
                self.performSegue(withIdentifier: "move", sender: nil)
            }else{
                print("error",error?.localizedDescription)
            }
            }
            
        }

    
    @IBAction func signUp1(_ sender: Any) {
        
        
    }

    
}
    

