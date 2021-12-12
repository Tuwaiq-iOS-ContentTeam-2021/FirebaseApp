//
//  ViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 09/12/2021.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let user = Auth.auth().currentUser
    
    @IBOutlet weak var passwordSignIn: UITextField!
    
    @IBOutlet weak var emailSignIn: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func signInFunc(){
        Auth.auth().signIn(withEmail: self.emailSignIn.text!, password: self.passwordSignIn.text!) { authResult, error in
            if error == nil{
                self.performSegue(withIdentifier: "segueSignIn", sender: nil)
                print("SIGNED")
            } else {
                print(error?.localizedDescription)
                return
            }
        }
    } // end of signIn()
    
    @IBAction func SignInButton(_ sender: Any) {
        signInFunc()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueSignIn" {
//           let vs =  ProfileViewController()
//            vs.nameUser = user?.displayName ?? ""
////            vs.userName = usernameSignUp.text!
//        }
//    }
}

