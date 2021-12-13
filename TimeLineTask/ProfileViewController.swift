//
//  ProfileViewController.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    var arr:[Users] = []
    let db = Firestore.firestore()
    let user = Auth.auth().currentUser
    var sendName = ""
    var sendUser = ""
    
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
    func getData() {
        db.collection("Users")
            .whereField("ID", isEqualTo: user?.uid)
            .getDocuments(
                completion: { [self]
                    (qurySnaShot, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        for document in qurySnaShot!.documents {
                            let data = document.data()
                            print(data["name"] as? String ?? "value not found")
                            let dataName =  document.get("name")! as! String
                               let dataUName = document.get("username")! as! String
                               let dataEmail = document.get("email")! as! String
                                let newUser = Users(name: dataName, username: dataUName, email: dataEmail)
                            self.sendUser = dataUName
                            self.sendName = dataName
                                self.arr.append(newUser)
                        }
                    }
                }
            )
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
        emailProfile.text = user?.email
        nameProfile.text = sendName
        usernameProfile.text = sendUser
    }
    
}
