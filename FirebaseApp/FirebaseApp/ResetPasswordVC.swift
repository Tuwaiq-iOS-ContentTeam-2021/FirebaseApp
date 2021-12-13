//
//  ReseatPasswordVC.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var buttonReset: UIButton!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttonReset.layer.cornerRadius = 15
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error == nil {
                
                let alert = UIAlertController(title: "Done", message: "You have received an email, check your email !" , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil ))
                
                self.present(alert, animated: true, completion: nil)
            }else {
                
                let alert = UIAlertController(title: "Alert", message: error?.localizedDescription , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: error!.localizedDescription), style: .default, handler: nil ))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
