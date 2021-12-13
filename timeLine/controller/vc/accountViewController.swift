//
//  accountViewController.swift
//  timeLine
//
//  Created by loujain on 11/12/2021.
//

import UIKit
import Firebase
class accountViewController: UIViewController {
    let db = Firestore.firestore()
    //get name and UserName from SingUpViewController
    var name1 : String?
    var nameUser1 : String?
    @IBOutlet weak var nameAc: UILabel!
    @IBOutlet weak var userNameAc: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        nameAc.text = name1
//        userNameAc.text = nameUser1
        getUserData()

    }
   
    @IBAction func backToTimeLine(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToTL", sender: nil)
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            //move to ViewController
            self.performSegue(withIdentifier: "moveToView", sender:self)
//            dismiss(animated: true, completion: nil)
        }catch let signOutError as NSError{
            print("Error" ,signOutError )
            
        }
    }
    
    func getUserData(){
            
            let email = Auth.auth().currentUser!.email!
            
            db.collection("Messages").document().parent.whereField("email", isEqualTo: email).getDocuments { QuerySnapshot, Error in
                
                
                if Error == nil {
                    
                    self.userNameAc.text = QuerySnapshot?.documents[0].get("name") as? String
                    
                }else{
                    print(Error!.localizedDescription)
                }
            }
        }

}
