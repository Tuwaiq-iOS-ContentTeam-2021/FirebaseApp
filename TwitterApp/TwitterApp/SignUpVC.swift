//
//  SignUpVC.swift
//  TwitterApp
//
//  Created by Aisha Al-Qarni on 12/12/2021.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signupBottun(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!){ authResult, error in
       
                   if error == nil {
                       self.performSegue(withIdentifier: "upToTimeline", sender: nil)
                       self.modalPresentationStyle = .fullScreen
                   }else{
                       print(error?.localizedDescription)
                   }
               }// end of creating new user
    }
}
