//
//  ViewController.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var buttonLoginOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonLoginOutlet.layer.cornerRadius = 15
        
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toReset", sender: nil)
        
    }
    
    @IBAction func loginButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text! , completion: { user, Error in
            
            if Error == nil {
                
                self.performSegue(withIdentifier: "VC", sender: nil)
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                
            }else{
                
                let alert = UIAlertController(title: "Alert", message: Error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        )
    }
    
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toCreate", sender: nil)

    }
}

