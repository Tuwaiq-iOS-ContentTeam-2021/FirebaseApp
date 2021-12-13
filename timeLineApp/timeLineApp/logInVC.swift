//
//  ViewController.swift
//  timeLineApp
//
//  Created by Areej on 11/12/2021.
//

import UIKit
import Firebase
class logInVC: UIViewController {
    
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signinAction(_ sender: Any) {
        signin (email: emailtxt.text!, password: passwordtxt.text!)
        
    }
    func signin (email: String, password: String){
        
        Auth.auth().signIn(withEmail: email , password: password) { AuthResult, err in
            if let error = err{
                print(err?.localizedDescription)
            }else{
                print("login process...")
                self.performSegue(withIdentifier: "moveToHome", sender: nil)
             
                
            }
        }
    }
}

