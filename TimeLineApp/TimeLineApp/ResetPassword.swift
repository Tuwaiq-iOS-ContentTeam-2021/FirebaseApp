//
//  ResetPassword.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 13/12/2021.
//

import UIKit
import Firebase

class ResetPassword: UIViewController {
    
    
    @IBOutlet weak var resetPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: resetPass.text!) { err in
            if err == nil {
                print("reset email send")
                self.performSegue(withIdentifier: "passreset", sender: self)
                
            } else {
                print("can't send email", err?.localizedDescription)
            }
        }
    }
    
    
    
    
}
