//
//  LogInVC.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 11/12/2021.
//

import UIKit
import Firebase

class LogInVC: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func userLogin(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            if error == nil {
                
                self.performSegue(withIdentifier: "gotohome", sender: self)
            } else {
                print("can't login!", error?.localizedDescription)
                self.checklogin()
                
                let alert = UIAlertController(title: "there is no account with this email", message: "pleas signup" , preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    func checklogin() {
        if emailField.text == "" && passwordField.text == "" {
            let alert = UIAlertController(title: "Please enter your email & password", message: nil , preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else if passwordField.text == "" {
            let alert = UIAlertController(title: "Please enter your password", message: nil , preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else if emailField.text == ""  {
            let alert = UIAlertController(title: "Please enter your email", message: nil , preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    
    
    
}
