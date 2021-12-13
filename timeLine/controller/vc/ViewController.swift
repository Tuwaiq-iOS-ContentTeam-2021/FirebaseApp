//
//  ViewController.swift
//  timeLine
//
//  Created by loujain on 09/12/2021.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
     // MARK: -
    
    @IBAction func singInButton(_ sender: Any) {
        signInFunc()
    }
    
    
    @IBAction func forgotButton(_ sender: Any) {
//        Auth.auth().currentUser?.updatePassword(to: resetPassTextF.text!) { error in
//            if error == nil{
//                self.dismiss(animated: true, completion: nil)
//                print("SIGNED")
//            } else {
//                print(error?.localizedDescription)
//                return
//            }
//        }
    }
    
     // MARK: -
    func signInFunc(){
        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) {
            authResult, error in
            if error == nil{
                // segue move to next page
                self.performSegue(withIdentifier: "moveTimeLine", sender: nil)
            }else{
                print(error?.localizedDescription)
                return //off the code
            }
        }
    }//end signInFunc()

}

