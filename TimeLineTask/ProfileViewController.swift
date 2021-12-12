//
//  ProfileViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    let user = Auth.auth().currentUser
    var nameUser = ""
    var userName = ""
    @IBOutlet weak var resetting: UITextField!
    
    @IBAction func changePassword(_ sender: Any) {
        Auth.auth().currentUser?.updatePassword(to: resetting.text!) { error in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
                print("SIGNED")
            } else {
                print(error?.localizedDescription)
                return
            }
        }
    }
    @IBAction func logOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
    }
    @IBOutlet weak var nameProfile: UILabel!
    
    @IBOutlet weak var emailProfile: UILabel!
    @IBOutlet weak var usernameProfile: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameProfile.text = nameUser
        usernameProfile.text = userName
//        usernameProfile.textColor = .blue
        emailProfile.text = user?.email
        
    }
    
}
