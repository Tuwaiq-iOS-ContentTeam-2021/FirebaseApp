//
//  SignUpViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 09/12/2021.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    
    
    @IBOutlet weak var passwordSignUp: UITextField!
    
    @IBOutlet weak var emailSignUp: UITextField!
    
    @IBOutlet weak var usernameSignUp: UITextField!
    
    @IBOutlet weak var nameSignUp: UITextField!
    
    let user = Auth.auth().currentUser
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func creatNewUser() {
        Auth.auth().createUser(withEmail: self.emailSignUp.text!, password: self.passwordSignUp.text!) { authResult, error in
            if error == nil{
                self.performSegue(withIdentifier: "segueSignUp", sender: nil)
                print("CREATED")
            } else {
                print(error?.localizedDescription)
            }
            
        }
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = self.nameSignUp.text
        changeRequest?.commitChanges { (error) in
            if error == nil {
                
                print("displayName done")
                print(Auth.auth().currentUser?.displayName)
            }else{
                
                print(error)
                
            }
        }
    } // end of creatNewUser()
    
    
    func addField(){
        self.db.collection("Users")
            .addDocument(data:
                            [
                                "name" : nameSignUp.text,
                                "email" : emailSignUp.text,
                                "username" : usernameSignUp.text,
                                "ID" : user?.uid
                            ])
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        creatNewUser()
        addField()
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "segueSignUp" {
               let vs =  ProfileViewController()
                vs.nameUser = user?.displayName ?? ""
                vs.userName = usernameSignUp.text!
            }
        }
}
