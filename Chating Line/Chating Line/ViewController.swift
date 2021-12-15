//
//  ViewController.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 06/05/1443 AH.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    
    @IBOutlet weak var liginEmail: UITextField!
    @IBOutlet weak var loginPassowrd: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: liginEmail.text! , password: loginPassowrd.text! ) { authResult, error in
            if error == nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "post") as! UITabBarController
                self.present(vc, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Please try again", message: "The Email or password is not valid", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                
                print(error!.localizedDescription)
            }
        }
    }
    
}














