//
//  ViewController.swift
//  TimelineApp
//
//  Created by Mola on 10/12/2021.
//

import UIKit
import Firebase

class SignInPage: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fillTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Already has account
    @IBAction func signIn(_ sender: Any) {
        if emailTextField.text == "" || passwordTextField.text == "" {
            passwordTextField.text = "Please fill all fields"
        }else{
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            if error == nil {
                self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                print("** signIn successfully **")
            }else{
                print(error?.localizedDescription)
            }
        }
    }


    }
    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

