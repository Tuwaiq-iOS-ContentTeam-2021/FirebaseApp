//
//  SignUpViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet var signUpButtonOutlet: UIButton!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButtonOutlet.layer.cornerRadius = 15
        
        
    
    }
    
    @IBAction func SignUpActionButton(_ sender: Any) {
        
        if let email = emailTextField.text {
            if let password = passwordTextField.text{
                if let confirmPassword = confirmPasswordTextField.text{
                    if password == confirmPassword {
                            
                            Auth.auth().createUser(withEmail: email, password: password) { AuthDataResult, Error in
                                
                                
                                if Error != nil {
                                    let alert = UIAlertController(title: "Error", message: "\(Error?.localizedDescription)", preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                                  
                                    self.present(alert, animated: true, completion: nil)
                                    
                                    print(Error?.localizedDescription ?? "ERROR" , "❎")
                                    
                                    
                                }else{
                                    
                                    print("Success")

                                    self.dismiss(animated: true, completion: nil)
                                    
                                }
                                
                            }
                            
                       
                    }else{
                        
                    }// password does not match
                    
                }else{
                    
                } // empty confirm password
                
            }else{
                
            } // empty password
            
        }else{
            
        } // empty email
        
        
        
        
    }
    
    
    
}
