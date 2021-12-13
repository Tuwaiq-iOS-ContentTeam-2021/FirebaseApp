//
//  SignUpViewController.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 10/12/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

  
    @IBOutlet weak var EmailSignUpTextFiled: UITextField!
    
    
    @IBOutlet weak var PasswordSignUpTextFiled: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func SignUpBuuton(_ sender: Any) {
        
        creatNewUsear(Email: EmailSignUpTextFiled.text!, Password: PasswordSignUpTextFiled.text!)
    }
    
    

    @IBAction func SigninBuuton(_ sender: Any) {
        SignInUser(Email: EmailSignUpTextFiled.text!, Password: PasswordSignUpTextFiled.text!)
    }
    
    
    
    
    
    func creatNewUsear(Email:String,Password:String){
        Auth.auth().createUser(withEmail: Email, password: Password) { AuthDataResult, error in
            
            
            if error == nil{
                
                
                print("signed up succesfully!")
            }else{
                
                print(error?.localizedDescription)
            }
        }
    
    }
    
    func SignInUser(Email:String,Password:String){
    
    
        
        Auth.auth().signIn(withEmail: Email, password: Password) { AuthDataResult, error in
            
            if error == nil {
                
                self.performSegue(withIdentifier: "moveHome", sender: nil)
                
                
                
            }else{
                
                print(error?.localizedDescription)
                
            }
            
        }
        
        
        
    }
    

}
