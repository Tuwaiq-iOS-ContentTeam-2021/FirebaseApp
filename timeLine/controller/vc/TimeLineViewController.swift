//
//  TimeLineViewController.swift
//  timeLine
//
//  Created by loujain on 10/12/2021.

import UIKit
import Firebase

class TimeLineViewController: UIViewController {
    
    let db = Firestore.firestore()
    let email = Auth.auth().currentUser?.email
    let userID = Auth.auth().currentUser?.uid
    var messages : [getData] = []
//    let refreshControl = UIRefreshControl()
    
    //get name and UserName from SingUpViewController
    var nameUser:String?
    var name:String?
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        loadMessages()
        tableView.delegate = self
        tableView.dataSource = self
        //        senderEmail.text = Auth.auth().currentUser?.email
        self.tableView.reloadData()
   
        
    }
    
    
    // MARK: -
    @IBAction func sendButton(_ sender: Any) {
        
        if let messageText = messageTextField.text ,
           let messageEmail = Auth.auth().currentUser?.email,
           let messagesId = Auth.auth().currentUser?.uid{
            //Save data to Cloud Firestore
            db.collection("Messages").addDocument(data: [
                    "name" : self.name,
                    "userName" : self.nameUser,
                    "text" : messageText,
                    "time" : FieldValue.serverTimestamp(),
                    "id"   : messagesId,
                    "email" :messageEmail
                ]){ (error) in
                    if let error = error{
                        print(error)
                    }else{
                        // need the for DispatchQueue,data may be delayed because it comes from DB
                        DispatchQueue.main.async {
                            //Delete the message after sending
                            self.messageTextField.text = ""
                        } // end DispatchQueue
                    }// else
                    self.tableView.reloadData()
                }
        } //end if
//        self.loadMessages()
        getUserData()


    }
    
    
    @IBAction func ProfileButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToAccount", sender: nil)
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            //move to ViewController
            dismiss(animated: true, completion: nil)
        }catch let signOutError as NSError{
            print("Error" ,signOutError )
            
        }
    }
    
    // MARK: -
    
    func getUserData(){
            
            db.collection("Messages").order(by: "time")
                .getDocuments{ (snapshot, error) in
                    
                    if let error = error {
                        
                        print(error.localizedDescription)
                        
                    }else {
                        
                        self.messages.removeAll()

                        for document in snapshot!.documents {
                            let test = getData(name: document.get("email") as! String, description: document.get("text") as! String)

                            
                            self.messages.append(test)

                        }
                        self.tableView.reloadData()

                    }
                }
        }
    
//    func loadMessages(){
//        db.collection("Messages")
//           .order(by: "time")
//            .getDocuments(completion: {
//                (querySnapshot, error) in
//                self.messages = []
//                if let error = error {
//                    print(error.localizedDescription)
//                }
//                else{
//                    for docuemnt in querySnapshot!.documents {
//                        print(docuemnt.get("text")!)
//                        let body = docuemnt.get("text")! as! String
//                        let email = docuemnt.get("email")! as! String
//
//                        let newMessage = Messages(name: "messagesender", body: body)
//                        self.messages.append(newMessage)
//                    }
//
//                    self.tableView.reloadData()
//
//                }
//            }) //end loadMessages()
//    }
    }


// MARK: -
extension TimeLineViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
//        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeLineCell") as! TableViewCell
        cell.nameLabel.text = messages[indexPath.row].name
//        cell.userNameLabel.text = messages[indexPath.row].userName
        cell.chatLabel.text = messages[indexPath.row].description
        return cell
    }
    
}


struct getData {
    
    var name : String
    var description : String
}

//struct Messages {
//    let name: String
////    let userName: String
//    let body: String
//}
