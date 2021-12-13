////
////  PostViewController.swift
////  timeLine
////
////  Created by loujain on 11/12/2021.
////
//
//import UIKit
//import Firebase
//class PostViewController: UIViewController {
//    @IBOutlet weak var textArea: UITextView!
//    let db = Firestore.firestore()
//    let email = Auth.auth().currentUser?.email
//    let userID = Auth.auth().currentUser?.uid
////4    //get name and UserName from SingUpViewController
//    var nameUser:String?
//    var name:String?
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    
//    @IBAction func postButton(_ sender: Any) {
//        sendDataFromDB ()
//        self.textArea.text = ""
//
//    }
//    
//    
//    func sendDataFromDB (){
//        
//        if let messageText = textArea.text ,
//           let messageEmail = Auth.auth().currentUser?.email,
//           let messagesId = Auth.auth().currentUser?.uid{
//            //Save data to Cloud Firestore
//            db.collection("Messages").addDocument(data: [
//                    "name" : name ,
//                    "userName" : nameUser,
//                    "text" : messageText,
//                    "time" : FieldValue.serverTimestamp(),
//                    "id"   : messagesId,
//                    "email" :messageEmail
//                ]){ (error) in
//                    if let error = error{
//                        print(error)
////                    }else{
////                        DispatchQueue.main.async {
////                            //Delete the message after sending
////                            self.textArea.text = ""
////                        } // end DispatchQueue
////                    }// else
//                }
//        } //end if
//    }
//    
//}
//}
