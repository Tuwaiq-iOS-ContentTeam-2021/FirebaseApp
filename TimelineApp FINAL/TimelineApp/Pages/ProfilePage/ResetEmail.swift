//
//  ResetEmail.swift
//  TimelineApp
//
//  Created by Mola on 12/12/2021.
//

import UIKit
import Firebase
class ResetEmail: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func update2(_ sender: Any) {
        Auth.auth().currentUser?.updateEmail(to: emailText.text!) { error in
            if error == nil{ 
                print("email is updated sucssfully")
            }else{
                print(error?.localizedDescription)
            }
        }
    }
    
}
