//
//  HomeViewController.swift
//  TimelineApp
//
//  Created by Ebtesam Alahmari on 10/12/2021.
//

import UIKit
import Firebase
class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var userId = Auth.auth().currentUser?.uid
    var posts = [Post]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    func getData()  {
        db.collection("Posts").order(by: "postDate", descending: true).addSnapshotListener { querySnapshot, error in
            self.posts = []
            if let error = error {
                print("Error: ",error.localizedDescription)
            }else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let newPost = Post(name: data["name"] as? String ?? "nil", userName: data["userName"] as? String ?? "nil", userIcon: data["userIcon"] as? String ?? "nil", postDate: data["postDate"] as? Date ?? Date(), postImage: data["postImage"] as? String ?? "nil" , message: data["message"] as? String ?? "nil")
                    self.posts.append(newPost)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}


//MARK: -UITableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! TableViewCell
        cell.postTxt.text = posts[indexPath.row].message
        cell.NameLbl.text = posts[indexPath.row].name
        cell.userNameLbl.text = posts[indexPath.row].userName
        cell.userImage.layer.cornerRadius = cell.userImage.frame.width/2
        cell.userImg.layer.cornerRadius = 10
        
        let imgStr = posts[indexPath.row].userIcon
        let url = "gs://timelineapp-8d435.appspot.com/images/" + "\(imgStr)"
        let Ref = Storage.storage().reference(forURL: url)
        Ref.getData(maxSize: 1 * 1024 * 1024) { dataImg, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                cell.userImage.image = UIImage(data:dataImg!)
            }
        }
        
        //----------------
        let imgPost = posts[indexPath.row].postImage
         let postImgURL = "gs://timelineapp-8d435.appspot.com/images/" + "\(imgPost!)"
        let Ref2 = Storage.storage().reference(forURL: postImgURL)
        Ref2.getData(maxSize: 1 * 1024 * 1024) { dataImg, error in
            if error != nil {
                print("Error: Image could not download!")
            } else {
                cell.userImg.image = UIImage(data:dataImg!)
            }
        }
        return cell
    }
}

