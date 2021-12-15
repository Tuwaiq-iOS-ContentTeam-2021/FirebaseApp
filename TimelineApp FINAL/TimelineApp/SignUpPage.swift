//
//  RegistrationPage.swift
//  TimelineApp
//
//  Created by Mola on 10/12/2021.
//

import UIKit
import Firebase
class SignUpPage: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let db = Firestore.firestore() // refrence
    let userID = Auth.auth().currentUser?.uid

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUp(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            authResult, error in
            if error == nil{ // no errors
                print("** New user account has been created **")
                self.db.collection("Users").addDocument(data:
                    [
                        "name" : self.nameTextField.text!,
                        "userID" : self.userID!
                    ])
                { error in
                    if error == nil { // no errors
                        print("** New document has been created **")
                        self.performSegue(withIdentifier: "SignUpToHome", sender: nil)
                    }else{
                        print("** Error saving user data **",error?.localizedDescription)
                    }
                }
            }else{
                print("** Error creating user account **",error?.localizedDescription)
            }
        }
    }

    
    // hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
