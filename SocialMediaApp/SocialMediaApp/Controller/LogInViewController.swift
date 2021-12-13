//
//  ViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 10/12/2021.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    @IBOutlet var logInWithGoogleButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIViews()
    }
    
    
    
    @IBAction func logInActionButton(_ sender: Any) {
        
        if let email = emailTextField.text
                  ,let password = passwordTextField.text {
                  
                signIn(email: email, password: password)
          
              }
    }
    
    
    @IBAction func logInWithGoogleActionButton(_ sender: Any) {}
    
}


extension LogInViewController {
    
    func setUpUIViews()  {
        
        logInButton.layer.cornerRadius = 15
        logInWithGoogleButton.layer.cornerRadius = 15
        signUpButton.layer.cornerRadius = 15
        
    }
    
    
    func signIn(email : String , password : String) {
    
          Auth.auth().signIn(withEmail: email, password: password){
              authResult, error in

              if error == nil {
                  
                  let tabBarViewCotroller = self.storyboard?.instantiateViewController(withIdentifier: "TabBarCotroller")
                  
                  tabBarViewCotroller?.modalPresentationStyle = .fullScreen

                  self.present(tabBarViewCotroller!, animated: true, completion: nil)
                  
              }else{
                  
                  let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                  
                  alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                  self.present(alert, animated: true, completion: nil)
                  
                  print("ERROR : ", error!.localizedDescription)
                
              }
          }
      }
    
    
}
