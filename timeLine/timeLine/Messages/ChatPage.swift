//
//  ChatPage.swift
//  timeLine
//
//  Created by nouf on 11/12/2021.
//

import UIKit
import Firebase

class ChatPage: UIViewController {

    
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var TextFiledForMsg: UITextField!
    let url = Firestore.firestore()
    var arrListMsg:[MsgStruct] = []
    var userID:String?
    var userName:String?
    let myID = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        reloadAllMsg(idUser: userID!)
    }
    
    func reloadAllMsg(idUser:String){
        arrListMsg.removeAll()
//        url.collection("Users").document(myID!).collection("Chat").document(self.userID!).collection("Message").getDocuments { snapShot, error in
//            for id in snapShot!.documents {
//                print(id.documentID)
//                print("content",id.get("content")!)
//
//
//                self.arrListMsg.append( MsgStruct(id: id.get("idUser")! as! String, content: id.get("content")! as! String))
//
//            }
//            self.TableViewChat.reloadData()
//        }
        url.collection("Users").document(myID!).collection("Chat").document(self.userID!).collection("Message").order(by: "date").addSnapshotListener { snapShot, error in
            self.arrListMsg.removeAll()
            print("_+_+_+_+_+_+")
            for id in snapShot!.documents {
                print(id.documentID)
                print("content",id.get("content")!)

                
                self.arrListMsg.append( MsgStruct(id: id.get("idUser")! as! String, content: id.get("content")! as! String))
                
            }
            self.TableView.reloadData()
        }
    }

    @IBAction func SendMessage(_ sender: Any) {
        let msg = [
                   "idUser":myID,
                   "date":dateSend(),
                   "content":TextFiledForMsg.text!]
        url.collection("Users").document(myID!).collection("Chat").document(userID!).collection("Message").document().setData(msg)
        url.collection("Users").document(userID!).collection("Chat").document(myID!).collection("Message").document().setData(msg)
        reloadAllMsg(idUser:userID!)
    }

    func dateSend()->String{
        let format = DateFormatter()
        format.dateFormat = "dd/mm/yyyy hh:mm:ss a"
        let date = format.string(from: Date())
        return date
    }

}


extension ChatPage: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrListMsg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "MessagCell", for: indexPath) as! MessagCell
        if myID == arrListMsg[indexPath.row].id {
            cell.nameUser.text = "Other User Me"
            cell.messag.text = arrListMsg[indexPath.row].content
        }else{
            cell.nameUser.text = "Other User"
            cell.messag.text = arrListMsg[indexPath.row].content
        }
        
        return cell
    }
    
    
}

struct MsgStruct {
    var id:String
    var content:String
    init(id:String,content:String){
        self.id = id
        self.content = content
    }
}

