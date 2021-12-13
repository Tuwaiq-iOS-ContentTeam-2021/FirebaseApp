//
//  LogoutVC.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase
class LogoutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

//    @IBAction func logout(_ sender: Any) {
//
       
    @IBAction func logout(_ sender: Any) {

    
        let logoutAlert = UIAlertController(title: "Are you sure you want a logout? ", message: "", preferredStyle: UIAlertController.Style.alert)
        logoutAlert.view.tintColor = UIColor.purple
     
    
        logoutAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
              print("Handle Logout logic here")
            do{
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            }catch {
                print(error.localizedDescription)
            }

        }))

        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        present(logoutAlert, animated: true, completion: nil)
        logoutAlert.view.backgroundColor = UIColor.white
      
    }

}

