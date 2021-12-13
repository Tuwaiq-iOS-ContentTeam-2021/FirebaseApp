//
//  Messages.swift
//  timeLine
//
//  Created by nouf on 11/12/2021.
//

import UIKit
import Firebase

class Messages: UIViewController {

    
    var user:[User] = []
    let url = Firestore.firestore()
    var sendUserID:String?
    var sendUserName:String?
    
    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.delegate = self
        
        url.collection("Users").getDocuments { Snapshot, error in
            print("-------------------")
            for ducment in Snapshot!.documents {
                
                print(ducment.documentID)
                print(ducment.data())
          
                self.user.append(User(name: ducment.get("Name") as? String  ?? " ", id: ducment.get("userID") as? String  ?? " "))
            
            }
            self.TableView.reloadData()
        }

    }
    
    @IBAction func LogOut(_ sender: Any) {
                do {
                    try Auth.auth().signOut()
                    dismiss(animated: true, completion: nil)
                }catch {
                    print(error)
                }
    }
    struct User {
        var name:String?
        var id:String?
        var imageUrl:String?
        init(name:String?,id:String){
            self.name = name
            self.id = id
//            ,imageUrl:String?
//            self.imageUrl = imageUrl
        }
    }

}
extension Messages : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "MessagCell", for: indexPath) as! MessagCell
        cell.nameUser.text = user[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sendUserID = user[indexPath.row].id
        sendUserName = user[indexPath.row].name
        performSegue(withIdentifier: "moveChat", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveChat"
        {
            let vcChat = segue.destination as! ChatPage
            
        
            vcChat.userID = sendUserID
            vcChat.userName = sendUserName
            
        }
    }
}
