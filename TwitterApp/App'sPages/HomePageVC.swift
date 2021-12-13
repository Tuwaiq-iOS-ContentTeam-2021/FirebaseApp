//
//  HomePageVC.swift
//  TwitterApp
//
//  Created by Nora on 06/05/1443 AH.
//

import UIKit
import Firebase

class HomePageVC: UIViewController{
    
    
    let db = Firestore.firestore()
    var tweets : [Tweet] = []
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        view.backgroundColor = .white
        view.addSubview(timeLineTV)
        view.addSubview(addtweetbtn)
        view.addSubview(profilebutton)
        timeLineTV.delegate = self
        timeLineTV.dataSource = self
        timeLineTV.reloadData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshTableView(_:)),for: .valueChanged)
        timeLineTV.addSubview(refreshControl)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        timeLineTV.frame = view.bounds
    }

    
    @objc func refreshTableView(_ sender: AnyObject) {
            
        tweets.removeAll()
        loadData()
        refreshControl.endRefreshing()
        }
    // i did organized all views in Closures
  
    let profilebutton : UIButton = {
        let profilebutton = UIButton()
        profilebutton.frame = CGRect(x: 50, y: 710, width: 80, height: 30)
        profilebutton.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        profilebutton.setTitle("profile", for: .normal)
        profilebutton.setTitleColor(.white, for: .normal)
        profilebutton.layer.cornerRadius = 15
        profilebutton.addTarget(self, action: #selector(profile), for: .touchDown)
        
        return profilebutton
    }()
    
    
    let timeLineTV : UITableView = {
        let timeLineTV = UITableView()
        timeLineTV.register(TweetCell.self,forCellReuseIdentifier: TweetCell.identifier)
        return timeLineTV
    }()
    
 
    let addtweetbtn : UIButton = {
        let addtweetbtn = UIButton()
        addtweetbtn.frame = CGRect(x: 300, y: 700, width: 50, height: 50)
        addtweetbtn.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        addtweetbtn.setTitle("+", for: .normal)
        addtweetbtn.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        addtweetbtn.setTitleColor(.white, for: .normal)
        addtweetbtn.layer.cornerRadius = 50
        addtweetbtn.addTarget(self, action: #selector(addTweet), for: .touchDown)
        
        return addtweetbtn
    }()
    
    
    @objc func addTweet() {
    let addTweetVC = AddTweetVC()
    addTweetVC.modalPresentationStyle = .fullScreen
    present(addTweetVC, animated: true, completion: nil)
 
}
    @objc func profile() {
    let profileVC = ProfileVC()
    profileVC.modalPresentationStyle = .fullScreen
    present(profileVC, animated: true, completion: nil)
 
}


  func loadData() {
      
      db.collection("Tweets").order(by: "timeStamp")
          .getDocuments(completion: {
          (querySnapshot, error) in
          self.tweets = []
          if let error = error {
            print(error.localizedDescription)
          }
          else{
            for docuemnt in querySnapshot!.documents {
              let content = docuemnt.get("content")! as! String
//            let time = docuemnt.get("timeStamp") as! Date
//              let name = Auth.auth().currentUser!.email
                let email = docuemnt.get("email")! as! String

                let newTweet = Tweet(email: email, content: content , timeStamp: Date())
              self.tweets.append(newTweet)
            }
            self.timeLineTV.reloadData()
          }
        }) //end loadMessages()
    }
    
}

    extension HomePageVC : UITableViewDataSource , UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = timeLineTV.dequeueReusableCell(withIdentifier: TweetCell.identifier,
                                                      for: indexPath) as! TweetCell

            cell.name.text = tweets[indexPath.row].email
            cell.content.text = tweets[indexPath.row].content
            
            return cell
        }
//        
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            print("hello nora")
//        }
//        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
    }

 

    
    


