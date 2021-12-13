////
////  HomeViewController.swift
////  timeLine
////
////  Created by loujain on 11/12/2021.
////
//
//import UIKit
//import Firebase
//class HomeViewController: UIViewController {
//    let db = Firestore.firestore()
//    let email = Auth.auth().currentUser?.email
//    let userID = Auth.auth().currentUser?.uid
//    var messages : [getData] = []
//    var nameUser:String?
//    
//    
//    @IBOutlet weak var tableView: UITableView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.delegate = self
//        tableView.dataSource = self
//        loadMessages()
//        self.tableView.reloadData()
//
//    }
//
//    
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
////                        let name = docuemnt.get("name")! as! String
//                        let newMessage = getData (name: "messageName")
//                        self.messages.append(newMessage)
//                    }
//                    
//                    self.tableView.reloadData()
//                    
//                }
//            }) //end loadMessages()
//    }
//}
//
//
//extension HomeViewController: UITableViewDataSource , UITableViewDelegate{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return messages.count
////        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
//        cell.name.text = messages[indexPath.row].name
////        cell.userName.text = messages[indexPath.row].userName
////        cell.chatTimeLine.text = messages[indexPath.row].description
//        return cell
//    }
//    
//}
