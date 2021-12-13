//
//  RegisterVC.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit
import Firebase
class RegisterVC: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    
    
    @IBOutlet weak var tfEmail: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func SignUpAction(_ sender: Any) {
        let name = tfName.text!
        let email = tfEmail.text!
        let password = tfPassword.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("لم ينجح التسجيل")
            }else{
                print("تم التسجيل")
            }
        }
        
    }
    
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
