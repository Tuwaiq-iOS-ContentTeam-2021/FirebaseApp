//
//  ViewController.swift
//  timeLine
//
//  Created by nouf on 09/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    //New user
    @IBOutlet weak var emailSignUp: UITextField!
    @IBOutlet weak var passwordSignUp: UITextField!
    @IBOutlet weak var nameUser : UITextField!
    
    //    login user
    @IBOutlet weak var passwordLogIn: UITextField!
    @IBOutlet weak var emailLogIn: UITextField!
    
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    //creat New user
    @IBAction func creatNewUser(_ sender: Any) {
        creatNewUser( email: emailSignUp.text! , password: passwordSignUp.text!)        
        creatUser()
    }
    
    //    log In user
    @IBAction func logInUser(_ sender: Any) {
        signIn(email:emailLogIn.text! , password : passwordLogIn.text!)
        
    }
    
    
    
    // MARK: - log In func
    func signIn(email: String , password : String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error == nil {
                
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                as! TabBar
                tabBar.modalPresentationStyle = .fullScreen
                self.present( tabBar, animated: true , completion: nil)
            } else {
                print(error!.localizedDescription)
                let alertController = UIAlertController(title: nil, message:"There was an error.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController , animated: true , completion: nil)
            }
        }
    }
    
    // MARK: - Sign up
    func creatNewUser(email: String , password : String) {
        
        Auth.auth().createUser(withEmail: email , password: password ) { authResult, error in
            
            
            if error == nil {
               
                //            authResult?.user.displayName = nameUser.text!
                let tabBar = self.storyboard?.instantiateViewController(withIdentifier: "TabBar")
                as! TabBar
                tabBar.modalPresentationStyle = .fullScreen
                self.present( tabBar, animated: true , completion: nil)
                
            } else {
                print(error!.localizedDescription)

                let alertController = UIAlertController(title: nil, message:"There was an error.", preferredStyle: .alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alertController , animated: true , completion: nil)
            }
            
        }
        
   
    
    }
    
    
    
    func creatUser() {
        
        db.collection("Users").document().setData([
            
            "Name" :  nameUser.text ?? " " ,
            "userID" :  user?.uid ??  "" ,
            "email" : emailSignUp.text! ,
            "imageProfile" : "person.circle" ,
           
        ]){ (error) in
        
            if let error = error {
                print("Error adding document: \(error.localizedDescription)")
                
            } else {
               
                print("Document added ")
            }
                 
        }
    }
    
    
    
  
    
    
}
