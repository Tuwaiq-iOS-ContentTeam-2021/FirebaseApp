//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Rayan Taj on 07/12/2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    var name = ""
    var id = ""
    var arrayOfMessages : [Message] = []
    let db = Firestore.firestore()
    var otherUserEmail = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForChanges()
    
    }
  

    @IBAction func sendButtonClicked(_ sender: Any) {
        sendMessage()
    }
    

}

// table view handler
extension ChatViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        
        
        chatTableViewCell.message.text = arrayOfMessages[indexPath.row].message
        
        let currentEmail = Auth.auth().currentUser?.email
        
        
        chatTableViewCell.userID.text = arrayOfMessages[indexPath.row].sender

        
//        if  currentEmail == arrayOfMessages[indexPath.row].sender {
//
//
//        }
        
        return chatTableViewCell
        
    }
    
    
}


// Message handler
extension ChatViewController{
    
    func listenForChanges()  {
        let currentEmail = Auth.auth().currentUser?.email
        let collectionRefrence =   db.collection("Users").document("\(currentEmail!)").collection("Messages").document(otherUserEmail).collection("msg")
            
        collectionRefrence.order(by: "timeStamp").addSnapshotListener {
            
            documentSnapshot, error in
                
            guard documentSnapshot != nil else {
                    print("Error fetching document: \(error!)")
                    return
                  }
            self.arrayOfMessages.removeAll()
            
            for item in documentSnapshot!.documents {

                let sender = item.get("sender")
                let message = item.get("content") as! String
                
                
                self.arrayOfMessages.append(Message(sender: sender as! String , message: message ))
            }
      
            self.tableView.reloadData()
            
            }
        
        
  
        
    }
    
    
    func sendMessage(){
        let currentEmail = Auth.auth().currentUser?.email
        
        
        let message = [ "sender" : "\(currentEmail!)" ,
            "content":"\(messageTextField.text!)", "timeStamp" : Date()] as [String : Any]
    
        
        db.collection("Users").document("\(currentEmail!)").collection("Messages").document(otherUserEmail).collection("msg").document()
            .setData(message)
        
        
        db.collection("Users").document("\(otherUserEmail)").collection("Messages").document("\(currentEmail!)").collection("msg").document()
            .setData(message)
        

        
    }
    
    
}
