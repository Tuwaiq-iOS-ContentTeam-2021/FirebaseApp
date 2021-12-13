//
//  SignInVC.swift
//  TwitterApp
//
//  Created by Aisha Al-Qarni on 12/12/2021.
//

import UIKit
import Firebase

class SignInVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signinBottun(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { authResult, error in
            if error == nil {
                self.performSegue(withIdentifier: "inToTimeline", sender: nil)
                self.modalPresentationStyle = .fullScreen
                
            }else{
                print(error?.localizedDescription)
            }
        }

    }
}
