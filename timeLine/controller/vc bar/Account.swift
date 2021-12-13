////
////  Account.swift
////  timeLine
////
////  Created by loujain on 13/12/2021.
////
//
//import UIKit
//import Firebase
//
//class Account: UIViewController {
//
//    @IBOutlet weak var name: UILabel!
//    @IBOutlet weak var userName: UILabel!
//    
//    var name1 : String?
//    var nameUser1 : String?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        name.text = name1
//        userName.text = nameUser1
//
//
//        // Do any additional setup after loading the view.
//    }
//    
//
//    @IBAction func logOutButton(_ sender: Any) {
//        do{
//            try Auth.auth().signOut()
//            //move to ViewController
//            self.performSegue(withIdentifier: "moveToView", sender:self)
////            dismiss(animated: true, completion: nil)
//        }catch let signOutError as NSError{
//            print("Error" ,signOutError )
//            
//        }
//    }
//    }
//    
//
