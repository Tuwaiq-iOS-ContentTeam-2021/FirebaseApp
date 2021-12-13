//
//  ViewController.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var textfieldPass: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 15

    }

    @IBAction func loginBtnClicked(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: textFieldEmail.text!, password: textfieldPass.text!) { user, error in
            if error == nil {
                
                self.performSegue(withIdentifier: "moveTimeline", sender: self)
            }else {
                let alertController = UIAlertController(title: "Alert", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                        
                        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                        
                            print("Ok button tapped");
                            
                        }
                        
                        alertController.addAction(OKAction)
                        
                        self.present(alertController, animated: true, completion:nil)
            }
        }
    }
    
}

