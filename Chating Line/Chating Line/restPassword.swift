//
//  restPassword.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 08/05/1443 AH.
//

import UIKit
import Firebase
import SwiftUI

class restPassword: UIViewController {
    
    @IBOutlet weak var newpassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func confirm(_ sender: Any) {
        if newpassword.text != ""{
            Auth.auth().currentUser?.updatePassword(to: newpassword.text!) { error in
                let alert = UIAlertController(title: "Alert", message: "New password has been updated", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
            }
        }else if newpassword.text == ""{
            let alert = UIAlertController(title: "", message: "please Enter a new password !", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}
