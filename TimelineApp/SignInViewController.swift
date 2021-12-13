//
//  ViewController.swift
//  TimelineApp
//
//  Created by Ebtesam Alahmari on 09/12/2021.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toHome", sender: nil)
        }
    }
    
    
    @IBAction func SignIn(_ sender: Any) {
        if emailTxt.text != "" && passwordTxt.text != "" {
            Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { authDataResult, error in
                if let error = error {
                    print("Error: ",error.localizedDescription)
                    let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.performSegue(withIdentifier: "toHome", sender: nil)
                }
            }
        }else {
            let alert = UIAlertController(title: "missing information", message: "Please enter email and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func forgotPasswordPressed(_ sender: Any) {
        var textFieldEmail = UITextField()
        let alert = UIAlertController(title: "Rest password", message: "Please add your email to rest password", preferredStyle: .alert)
        alert.addTextField { alartTextField in
            alartTextField.placeholder = "Enter your email"
            textFieldEmail = alartTextField
        }
        
        let OkBtu = UIAlertAction(title: "OK", style: .default) { action in
            if textFieldEmail.text != ""  {
                Auth.auth().sendPasswordReset(withEmail: textFieldEmail.text!) { error in
                    if error != nil {
                        print(error?.localizedDescription)
                    }
                }
            }
        }
        alert.addAction(OkBtu)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

