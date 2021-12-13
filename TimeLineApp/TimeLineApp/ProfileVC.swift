//
//  ProfileVC.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 11/12/2021.
//

import UIKit
import Firebase
class ProfileVC: UIViewController {
    @IBOutlet weak var emailLable: UILabel!
    
    let email = Auth.auth().currentUser!.email!
   var idSams = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLable.text = email
            }
    

    @IBAction func signOut(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "are you sure you want to logout ?", preferredStyle:.alert )
        let action = UIAlertAction(title: "Logout", style: .destructive) { action in
            do{
                
                
               try Auth.auth().signOut()
                
                self.dismiss(animated: true, completion: nil)
                
                print("تم تسجييل الخروج")
                
                
            }catch{
                
                print(error.localizedDescription)
            }
            
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBAction func resetPassword(_ sender: Any) {
        
//        PhoneAuthProvider.provider().verifyPhoneNumber("+966503998382", uiDelegate: nil) { incode, erorr in
//            if erorr == nil{
//
//                self.idSams = incode!
//
//            }else{
//
//                print(erorr?.localizedDescription)
//
//
//
//            }
//
//
//        }
        
    }
    
}
