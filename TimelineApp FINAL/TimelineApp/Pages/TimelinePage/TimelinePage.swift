//
//  HomePage.swift
//  TimelineApp
//
//  Created by Mola on 11/12/2021.
//

import UIKit
import Firebase
class TimelinePage: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var myTableView: UITableView!
    var postList = [Post]()
//    let userID = Auth.auth().currentUser?.uid //?
    var ref: DatabaseReference!
    var massages = [Massages]()

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        postList.append(Post(postText: "", userUID: "", postImage: "", postEmail: ""))

        myTableView.delegate = self
        myTableView.dataSource = self
        loadPostFromFirebase()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TimelineCell
        let post = postList[indexPath.row]

//        cell.setText(postText: post.postText!)
//        cell.setImage(ImageUrl: post.postImage!) // --- @
        cell.setPost(post: post)
        
//        cell.setText(postText: post.postText)
//        cell.userID = self.userID

        return cell
    }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    func newLoadData() {
        let db = Firestore.firestore() // refrence

          db.collection("Users")
              .getDocuments(completion: {
              (querySnapshot, error) in
              self.massages = []
              if let error = error {
                print(error.localizedDescription)
              }
              else{
                for docuemnt in querySnapshot!.documents {
                  let text = docuemnt.get("text")! as! String
    //            let time = docuemnt.get("name") as! String
    //              let name = Auth.auth().currentUser!.email
                    let email = docuemnt.get("email")! as! String

                    let newTweet = Massages(email: email)
                  self.massages.append(newTweet)
                }
//                self.timeLineTV.reloadData()
              }
            })
        }
        
    
    //data base
    func loadPostFromFirebase(){ // lesten for this child(post nod) for any change happen
        ref.child("Posts").observe(.value, with: {
            (snapshot) in
            self.postList.removeAll() // remove all the post
            self.postList.append(Post(postText: "", userUID: "", postImage: "",postEmail: ""))
// reading all nods
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] { //snapshot will bring all objects (key and value) "listening to the post"
                for snap in snapshot{
                    if let postDic = snap.value as? [String:Any]{  // to get values for every nod
                        var postText:String?
                        if let postTextF = postDic["text"] as? String{
                            postText = postTextF
                        }
                        
                        var userUID:String?
                        if let userUIDF = postDic["userUID"] as? String{
                            userUID = userUIDF
                        }
                        
                        var postImage:String?
                        if let postImageF = postDic["imagePath"] as? String{
                            postImage = postImageF
                        }
                        var postEmail:String?
                        if let postEmailF = postDic["email"] as? String{
                            postEmail = postEmailF
                        }
                        
                        self.postList.append(Post(postText: postText!, userUID: userUID!, postImage: postImage ?? "no immage",postEmail: postEmail ?? "@UserName" )) //
// 
                    }
                }
                // when he done from loading all this for loop
                // i need to reload the table view
                self.myTableView.reloadData()
            }
        })
    }

 
}
