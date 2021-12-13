//
//  PostVC.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftUI

class PostVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var tblPosts : UITableView!
    
    var myPostsDict: [String: Post] = [:]
    var myPostsArray: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblPosts.estimatedRowHeight = 80
        self.tblPosts.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.observePosts()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
   
    
    func observePosts() {
        firebaseManager.getPosts() { (key, valuesDict) in
            self.myPostsDict = Post.posts(dict: valuesDict as! [AnyHashable : Any])
            self.myPostsArray = self.myPostsDict.values.sorted(by: { (user1, user2) -> Bool in
                return user1.postTimeIntervals < user2.postTimeIntervals
            })
            
            self.tblPosts.reloadData()
        }
    }
    
    
    @IBAction func btnLogOutClicked(){
        do{
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error while signing out!")
        }
    }
    
}


extension PostVC {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myPostsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
        let thisPost = self.myPostsArray[indexPath.row]
        cell.txtPost.text = thisPost.postText
        
        
        let date = Date(timeIntervalSince1970: thisPost.postTimeIntervals)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm - MM/dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let dateString = dateFormatter.string(from: date)
        
        cell.lblPostTime.text = dateString
        
        
        
        if thisPost.postImageUrl != "" {

            let cachy = CachyLoader()

            cachy.loadWithURL(URL(string: thisPost.postImageUrl)!) { [weak self] data, _ in
                cell.imgPerson.image = UIImage(data: data)
            }

        }else{
            cell.imgPerson.image = UIImage(systemName: "person.circle.fill")
        }
        
        cell.lblUserName.text = thisPost.postPersonName;
        
        return cell
        
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}
