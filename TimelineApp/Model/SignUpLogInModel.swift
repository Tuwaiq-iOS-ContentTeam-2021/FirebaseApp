//
//  SignUpModel.swift
//  TimelineApp
//
//  Created by WjdanMo on 10/12/2021.
//
import UIKit
import Foundation
import Firebase
import FirebaseFirestore

class SignUpLogInModel{
    
    let db = Firestore.firestore()
    
    func signUpAction(_ name: String,_ username: String, _ email: String, _ password: String) -> Bool {
        
        //        let user = User(name: name,
        //                        userName: userName,
        //                        email: email,
        //                        password: password)
        
        var returnVal = true
        
        Auth.auth().createUser(withEmail: email , password: password ) { authResults, error in
            if error == nil{
                if let uId = Auth.auth().currentUser?.uid{
                let user = ["name": name,
                            "userName": username,
                            "email": email,
                            "id": uId]
                    self.db.collection("Users").document(username).setData(user as [String : Any])
                }
                
                
                print("done")
            }else{
                returnVal = false
                print(error?.localizedDescription as Any)
            }
        }
        
        return returnVal
        
        //        if let name = name, let userName = userName, let email = email, let password = password{
        //            let user = ["name": name,
        //                                    "userName": userName,
        //                                    "email": email,
        //                                    "password": password]
        //
        //                      db.collection("Users").document(userName).setData(user)
        //        }
        
    }
    
    func logInAction(_ email : String,_ password : String) -> Bool{
        var loginState = true
        Auth.auth().signIn(withEmail: email , password: password ) { authResults, error in
            if let error = error {
                loginState = false
                print(error.localizedDescription as Any)
            }
        }
        return loginState
    }
}


//public struct User: Codable{
//    
//    let name : String
//    let userName : String
//    let email : String
//    let password : String
//    
//    enum CodingKeys: String, CodingKey {
//            case name
//            case userName
//            case email
//            case password
//        }
//}
