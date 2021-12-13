//
//  timeLineVC.swift
//  timeLineApp
//
//  Created by Areej on 11/12/2021.
//

import UIKit
import Firebase
import FirebaseStorage
import SwiftUI
class timeLineVC: UIViewController,
                  UITableViewDataSource, UITableViewDelegate
{
    let db = Firestore.firestore()
    let image = Auth.auth().currentUser?.photoURL
    
    var arrayPost = [Posts]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = arrayPost[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! postViewCell
        cell.nameofUser.text = arrayPost[indexPath.row].name
        cell.txtPost.text = arrayPost[indexPath.row].textPost
        cell.emailOfUser.text = arrayPost[indexPath.row].emailaccount
        cell.imgPost.image = UIImage(named: "cat")
      
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        readdata ()
    }
    
    @IBAction func addtweetAction(_ sender: Any) {
        
    }
    @IBAction func comment(_ sender: Any) {
    }
    @IBAction func like(_ sender: Any) {
    }
    @IBAction func share(_ sender: Any) {
        shareSheet()
    }
    
    
    
    func readdata (){
        
        db.collection("tweets").getDocuments { QuerySnapshot, err in
            if let error = err{
                
                print(error.localizedDescription)
            }else{
              
                for document in QuerySnapshot!.documents {
                    let data = document.data()
                    self.arrayPost.append(Posts(data["username"] as? String ?? "not valid username!", data["text"] as? String ?? "no text", data["emailaccount"] as? String ?? "something wrong with account!"))
                    
                    print(data["username"] as? String ?? "not valid username!")
                    print(data["text"] as? String ?? "not valid text!" )
                    self.tableView.reloadData()
                }
            }
        }
    }
    func shareSheet (){
        let image = UIImage(named: "m1")!
        let url = URL(string: "http://www.google.com")
       
        let share = UIActivityViewController(activityItems: [
            image,
            url
        ],
        applicationActivities: nil)
     
        self.present(share, animated: true, completion: nil)
    }
    
    
}
