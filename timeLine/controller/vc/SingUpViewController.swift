//
//  SingUpViewController.swift
//  timeLine
//
//  Created by loujain on 10/12/2021.
//

import UIKit
import Firebase
class SingUpViewController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     // MARK: -
    @IBAction func singUpButton(_ sender: Any) {
        creatUser()
        
    }
    
    func creatUser (){
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { user, Error in
            
            if Error == nil {
                self.db.collection("Messages")
                    .document().setData(
                        [
                            "email" : self.emailTextField.text!,
                            "name" : self.nameTextField.text!
                        ])
                {(error) in
                    if error == nil {
                        print("Added Succ..")
                    }else {
                        print(error!.localizedDescription)
                    }
                }
                
                self.dismiss(animated: true, completion: nil)
                
            }else{
                print(Error?.localizedDescription)
            }
        }
        
    }
    
     // MARK: -
//    func creatNewUser() {
//        //create account sign up new users
//   Auth.auth().createUser(withEmail: self.emailTextField.text!,password: self.passwordTextField.text!)
//        { authResult, error in
//            //chec for error
//            if error == nil{
//                self.performSegue(withIdentifier: "moveToTimeLine", sender: nil)
//                 print("New account created successfully")
//                self.addInfoUser()
//
//            }else{
//                print(error?.localizedDescription)
//            }
//        } // end of createing new user
//    }
    
    
//    func addInfoUser(){
//        self.db.collection("User")
//            .addDocument(data: [
//                "name" : nameTextField.text! ,
////                "userName" : userNameTextField.text!,
//                "email" : emailTextField.text ])
//
//    }
    
     // MARK: -
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         if segue.identifier == "moveToTimeLine"{
//             let vc = TimeLineViewController()
//             vc.name = nameTextField.text
//             vc.nameUser = userNameTextField.text
//            
//         }
//     }
}
