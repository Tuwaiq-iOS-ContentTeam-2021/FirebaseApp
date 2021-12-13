//
//  ViewController.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let fireStoreURL = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        createNewUser(email: "test@example.com", password: "123456")
    //Auth.auth.currentUser.
        }
   // end of viewDidLoad

//MARK:
    func createNewUser(email:String, password:String) {
        
        Auth.auth().createUser(withEmail: email, password: password) {
                 AuthResult, error in
                 
                 if error == nil {
                     print("تم إنشاء حساب جديد بنجاح")
                 }else{
                     print(error?.localizedDescription)
                 }
                 
             }
    //end of creating new user

   //end of creatingNewUser
    
    func signIn() {
      
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
         if error == nil {
                    self.performSegue(withIdentifier: "move", sender: nil)
         }else{
          // ...
        }
    }// end of sign in


}
    }
}
