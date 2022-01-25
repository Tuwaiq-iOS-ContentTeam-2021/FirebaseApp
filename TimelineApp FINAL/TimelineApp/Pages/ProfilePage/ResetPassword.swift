//
//  ResetPassword.swift
//  TimelineApp
//
//  Created by Mola on 12/12/2021.
//

import UIKit
import Firebase
class ResetPassword: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

        @IBAction func update1(_ sender: Any) {
            Auth.auth().currentUser?.updatePassword(to: passwordText.text!) { error in
                if error == nil{ // no errors
                    print("** password updated **")
                }else{
                    print(error?.localizedDescription)
                }        }
        }
}
