//
//  SettingVc.swift
//  TimeLineApp
//
//  Created by Badreah Saad on 11/12/2021.
//

import UIKit
import Firebase


class SettingVc: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var userImage: UIImageView!
    
    
    let db = Firestore.firestore()
    let userNameDis = Auth.auth().currentUser?.displayName
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = " @ \(userNameDis!)"
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.clipsToBounds = true
    }
    
    
    @IBAction func userLogout(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to LogOut", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Log Out", style: .default) {_ in
            
            do {
                try Auth.auth().signOut()
                self.performSegue(withIdentifier: "logout", sender: self)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func chngePassword(_ sender: Any) {
        Auth.auth().currentUser?.updatePassword(to: newPassword.text!) { error in
            if error == nil {
                print("changed")
            } else {
                print("error!", error?.localizedDescription)
            }
        }
    }
    
    
    
    @IBAction func deleteUserAccount(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "Are you sure you want to delete your account ?", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Delete", style: .default) {_ in
            let user = Auth.auth().currentUser
            
            user?.delete { error in
                if let error = error {
                    print("can't be deleted!", error.localizedDescription)
                } else {
                    print("acouunt deleted!!")
                    self.performSegue(withIdentifier: "logout", sender: self)
                    
                }
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

        
    }
    
    
    
    
    
}


