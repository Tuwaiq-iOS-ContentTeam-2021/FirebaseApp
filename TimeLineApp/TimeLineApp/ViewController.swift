//
//  ViewController.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 09/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var idSams = ""

    @IBOutlet weak var EmailTextFiled: UITextField!
    
    @IBOutlet weak var PasswordTextFiled: UITextField!
    
    @IBOutlet weak var vlidationLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func hidePass(_ sender: Any) {
        PasswordTextFiled.isSecureTextEntry.toggle()
    }
    
    @IBAction func LoginBuuton(_ sender: Any) {
        
        SignInUser(Email: EmailTextFiled.text!, Password: PasswordTextFiled.text!)
    }
    
    
    
    
    @IBAction func forgetPasswordAcation(_ sender: Any) {
        
//        PhoneAuthProvider.provider().verifyPhoneNumber("+966503998382", uiDelegate: nil) { incode, erorr in
//            if erorr == nil{
//
//                self.idSams = incode!
//
//            }else{
//
//                print(erorr?.localizedDescription)
//
//
//
//            }
//
//
//        }
        
        
        
    }
    
    
    
    
  
    
    
    func SignInUser(Email:String,Password:String){
        
        Auth.auth().signIn(withEmail: Email, password: Password) { AuthDataResult, error in
            
            if error == nil {
                
               //self.performSegue(withIdentifier: "moveHome", sender: nil)
                
                self.performSegue(withIdentifier: "tabBar", sender: self)
                
            }else{
                
                self.vlidationLable.text! = "Email or paswored is Erorre"
                print(error?.localizedDescription)
                
            }
            
        }
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

