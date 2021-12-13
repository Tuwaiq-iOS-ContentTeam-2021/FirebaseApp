//
//  ViewController.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInAction(_ sender: Any) {
        let email = tfEmail.text!
        let password = tfPassword.text!
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            }else{
//                self.performSegue(withIdentifier: "toTimeLine", sender: nil)
                let tb = self.storyboard?.instantiateViewController(withIdentifier: "tabBarID") as! UITabBarController
                
                tb.modalPresentationStyle = .fullScreen
                
                self.present(tb, animated: true, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func forgiteAction(_ sender: Any) {
        
    }
}

