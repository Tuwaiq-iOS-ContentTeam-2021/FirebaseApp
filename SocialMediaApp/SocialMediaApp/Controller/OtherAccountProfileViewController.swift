//
//  OtherAccountProfileTableViewCell.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit
import Firebase
class OtherAccountProfileViewController: UIViewController {

    @IBOutlet var directMessageButtonOutlet: UIButton!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    var userEmail = ""
    let db = Firestore.firestore()
    var tweetsArray : [Tweet] = []
    let imagefolder = Storage.storage().reference().child("profileImages")
    
    override func viewDidLoad() {
        
        directMessageButtonOutlet.layer.cornerRadius = 15
        
        tableView
            .register(UINib(nibName: "ProfileTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTweetTableViewCell")
        
        profileImage.layer.cornerRadius = profileImage.frame.height/2

        emailLabel.text = userEmail
        getTweets()
        downloadImage()
        
        
    }

  
    @IBAction func directMessageActionButton(_ sender: Any) {
        
        let directChatVC = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        
        directChatVC.otherUserEmail = userEmail
        directChatVC.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(directChatVC, animated: true)
        
        
    }
    
}



// tableView handler
extension OtherAccountProfileViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetTableViewCell", for: indexPath) as!
        ProfileTweetTableViewCell
        
    
           tweetCell.tweetContent.text = tweetsArray[indexPath.row].content
          

           return tweetCell
        
    }
    
}


//  profile images handler
extension OtherAccountProfileViewController {
    
    func downloadImage(){
        let imageRefrence = imagefolder.child("\(userEmail)")
        
        imageRefrence.getData(maxSize: 1 * 1024 * 1024) { data, error in
          if let error = error {

          } else {
            
            let image = UIImage(data: data!)
              
              self.profileImage.contentMode = .scaleAspectFill
              self.profileImage.image = image
          }
        }
 
    }
    
    func getTweets() {
        
        tweetsArray.removeAll()
        
        db.collection("tweets").whereField("email", isEqualTo: userEmail).getDocuments { [self] QuerySnapshot, Error in
            
            
            if Error == nil{
                
                
                for document in QuerySnapshot!.documents {
                    
              
                let email = document.get("email")!
                let content = document.get("tweetContent")!
                let date = document.get("timeStamp")!
                
                    self.tweetsArray.append(Tweet(email: email as! String, content: content as! String , image: profileImage.image!))

                }
                
                self.tableView.reloadData()
            }else{
                
                print(Error?.localizedDescription, "❎")
            }
            
            
        }
        
       
        
    }
    
    
    
    
}
