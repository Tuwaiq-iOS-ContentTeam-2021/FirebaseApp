//
//  HomeViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit
import Firebase

class HomeViewController: UIViewController  {
    
    @IBOutlet var tableView: UITableView!
    
    var email = ""
    var profileImageRefernce : StorageReference? = nil
    
    let currerntUID = Auth.auth().currentUser!.uid
    let currerntEmail = Auth.auth().currentUser!.email!
    let db = Firestore.firestore()
    let refreshControl = UIRefreshControl()
    let imagefolder = Storage.storage().reference().child("profileImages")
    var tweetsArray : [Tweet] = []
    let storageRef = Storage.storage().reference()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
          refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
      
        getTweets()
    
    }

    
    @objc func refresh(_ sender: AnyObject) {
        tweetsArray.removeAll()
        getTweets()

        refreshControl.endRefreshing()
    }
    
    
    func getTweets()  {
        
        tweetsArray.removeAll()
        
        db.collection("tweets").order(by:"timeStamp").getDocuments { [self] QuerySnapshot, Error in
            
            
            if Error == nil{

                for document in QuerySnapshot!.documents {
                    
              
                    email = document.get("email")! as! String
                let content = document.get("tweetContent")!
                
                     profileImageRefernce = storageRef.child("profileImages/\(email)")

                    
                    self.tweetsArray.append(Tweet(email: email as! String, content: content as! String , image: UIImage(systemName: "person")! ))
                    
                
                                
                }
                tweetsArray.reverse()
                self.tableView.reloadData()
                
                
//                                    for i in 0...tweetsArray.count {
//
//                                        profileImageRefernce!.getData(maxSize: 1 * 1024 * 1024) { data, error in
//
//                                                        if let error = error {
//
//                                                      } else {
//
//                                                        let image = UIImage(data: data!)
//                                                          print("DONE")
//
//                                                          if tweetsArray[i].email == email as! String{
//
//                                                              tweetsArray[i].image = image!
//
//                                                          }
//
//
//                                                      }
//
//                                                        self.tableView.reloadData()
//                                                    }
//
//
//                                    }
            }else{
                
                let alert = UIAlertController(title: "Error", message: "\(Error?.localizedDescription)", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
              
                self.present(alert, animated: true, completion: nil)
                
                print(Error!.localizedDescription, "❎")
            }
            
            
        }
        
    }

    
    @IBAction func AddTweetActionButton(_ sender: Any) {}
    

}





extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tweetsArray.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
     
        
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "tweetImageTableViewCell") as!
        tweetImageTableViewCell
        
        tweetCell.email.text = tweetsArray[indexPath.row].email
        tweetCell.content.text = tweetsArray[indexPath.row].content
        tweetCell.profile.image = tweetsArray[indexPath.row].image
        tweetCell.profile.layer.cornerRadius =  tweetCell.profile.frame.height/2
        tweetCell.profile.contentMode = .scaleAspectFit

        return tweetCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let userVC = storyboard?.instantiateViewController(withIdentifier: "OtherAccountProfileViewController") as! OtherAccountProfileViewController
        
        
        userVC.modalPresentationStyle = .fullScreen
        userVC.userEmail = tweetsArray[indexPath.row].email
        
        self.navigationController?.pushViewController(userVC, animated: true)
        
        
        
    }
    
    
    
}


