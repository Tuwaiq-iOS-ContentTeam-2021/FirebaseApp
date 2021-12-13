//
//  Profile.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 07/05/1443 AH.
//

import UIKit
import Firebase

class Profile: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to LogOut", preferredStyle: .alert)
        let action = UIAlertAction(title: "Log out", style: .default) {_ in
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
}
