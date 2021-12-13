//
//  ChangePasswordViewController.swift
//  timeLine
//
//  Created by loujain on 11/12/2021.
//

import UIKit
import Firebase
class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var changeLabel: UILabel!
    @IBOutlet weak var ChangePasswordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Auth.auth().currentUser
        
        changeLabel.text = "\(user?.email ?? "email not found")"
        // Do any additional setup after loading the view.
    }
    

    @IBAction func ChangePasswordButton(_ sender: Any) {
//        let vc = SingUpViewController()
        Auth.auth().currentUser?.updatePassword(to: ChangePasswordText.text!)
        { error in
            if error == nil{
//                self.present(vc, animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
                print("Change")
            } else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    
}
