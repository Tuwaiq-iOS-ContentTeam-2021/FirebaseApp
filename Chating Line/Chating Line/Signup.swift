//
//  Signup.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 07/05/1443 AH.
//

import UIKit
import Firebase
class Signup: UIViewController {
    
    @IBOutlet weak var signUpName: UITextField!
    
    @IBOutlet weak var signUpEmail: UITextField!
    
    @IBOutlet weak var signUpPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        createnewuser(email: signUpEmail.text!, password: signUpPassword.text!)
    }
    
    func createnewuser(email: String, password: String){
        Auth.auth().createUser(withEmail: email , password: password) {
            authResult, error in
            if error == nil {
                let alert = UIAlertController(title: "Alert", message: "new account has been created successfully", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "post") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
                
            }else{
                print(error!.localizedDescription)
            }
            
        }
    }
}
