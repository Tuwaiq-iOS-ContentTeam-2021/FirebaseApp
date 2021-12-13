//
//  ForgetpassViewController.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 12/12/2021.
//

import UIKit
import Firebase
class ForgetpassViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func resetAcation(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
              if error == nil {
                  
              }
            }
    }
    

}
