//
//  SignUpVC.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit
import Firebase
class SignUpVC: UIViewController {
    
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPass: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        signUpBtn.layer.cornerRadius = 15
                
        textFieldPass.isSecureTextEntry = true

    }
    

    @IBAction func SignUpBtnClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: textFieldEmail.text!, password: textFieldPass.text!) { user, error in
            
            if error == nil {
                
                print("user id: \(user!.user.uid)")
                
                self.dismiss(animated: true, completion: nil)
            
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

    @IBAction func switchToLogin(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
