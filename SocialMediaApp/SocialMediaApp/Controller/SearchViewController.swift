//
//  SearchViewController.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 13/12/2021.
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    
    let db = Firestore.firestore()
    var tweetsArray : [Tweet] = []

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView
            .register(UINib(nibName: "ProfileTweetTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileTweetTableViewCell")    }
    

    @IBAction func searchButtonAction(_ sender: Any) {
        
        
        tweetsArray.removeAll()
        
        db.collection("tweets").whereField("tweetContent", isEqualTo: searchTextField.text!).getDocuments { [self] QuerySnapshot, Error in
            
            
            if Error == nil{
                
                
                for document in QuerySnapshot!.documents {
                    
              
                let email = document.get("email")!
                let content = document.get("tweetContent")!
                
                    self.tweetsArray.append(Tweet(email: email as! String, content: content as! String , image: UIImage(systemName: "person")!))

                }
                
                self.tableView.reloadData()
            }else{
                
                print(Error?.localizedDescription, "❎")
            }
            
            
        }
        
        
        
        
    }


}


extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tweetCell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetTableViewCell", for: indexPath) as!
        ProfileTweetTableViewCell
        
    
           tweetCell.tweetContent.text = tweetsArray[indexPath.row].content
          

           return tweetCell
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        
        let userVC = storyboard?.instantiateViewController(withIdentifier: "OtherAccountProfileViewController") as! OtherAccountProfileViewController
        
        
        userVC.modalPresentationStyle = .fullScreen
        userVC.userEmail = tweetsArray[indexPath.row].email
        
        self.navigationController?.pushViewController(userVC, animated: true)
        
    }
   
    
}
