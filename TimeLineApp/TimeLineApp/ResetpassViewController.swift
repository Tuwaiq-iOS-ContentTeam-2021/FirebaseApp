//
//  ResetpassViewController.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 13/12/2021.
//

import UIKit
import Firebase
class ResetpassViewController: UIViewController {

    
    @IBOutlet weak var resetPassTextFiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func ResetAcation(_ sender: Any) {
        Auth.auth().currentUser!.updatePassword(to: resetPassTextFiled.text! ) { error in
            if error == nil {
                print("updata rest")
                print(self.resetPassTextFiled.text!)
               
            }else {
                print(error?.localizedDescription)
            }
        }
        
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
        let alert = UIAlertController(title: "", message: "are you sure you want to logout ?", preferredStyle:.alert )
        let action = UIAlertAction(title: "Logout", style: .destructive) { action in
            do{
                
                
                
               try Auth.auth().signOut()
                self.performSegue(withIdentifier: "out", sender: nil)
                
               // self.dismiss(animated: true, completion: nil)
                
                print("تم تسجييل الخروج")
                
                
            }catch{
                
                print(error.localizedDescription)
            }
            
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
}
