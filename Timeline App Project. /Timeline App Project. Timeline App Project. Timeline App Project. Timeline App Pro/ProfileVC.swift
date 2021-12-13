//
//  ProfileVC.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    @IBAction func SignOut(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "انت متاكدمن الخروج", preferredStyle: .alert)
        let action = UIAlertAction(title: "نعم", style: .destructive) { action in
            
           
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch  {
                print(error.localizedDescription)
            }
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "لا", style:.cancel, handler: nil))
        present(alert, animated: true, completion: nil)

}
}
