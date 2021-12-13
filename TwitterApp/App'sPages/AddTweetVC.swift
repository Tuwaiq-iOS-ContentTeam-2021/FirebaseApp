//
//  addTweet.swift
//  TwitterApp
//
//  Created by Nora on 08/05/1443 AH.
//

import UIKit
import Firebase

class AddTweetVC: UIViewController {

    let db = Firestore.firestore()
    let name = ""
    let user = Auth.auth().currentUser
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tweetField)
        view.addSubview(cancelButton)
        view.addSubview(tweetbtn)
        
    }
    
    
    // i did organized all views in Closures
    
    let tweetField : UITextField = {
        let tweetField = UITextField()
        tweetField.frame = CGRect(x: 40, y: 100, width: 300, height: 100)
        tweetField.placeholder = "What's happening?"
        tweetField.textColor = #colorLiteral(red: 0.1448850334, green: 0.2240020931, blue: 0.1941880286, alpha: 1)
        
        return tweetField
    }()
    
    let cancelButton : UIButton = {
        let cancelBtn = UIButton()
        cancelBtn.frame = CGRect(x: 30, y: 60, width: 60, height: 50)
        cancelBtn.setTitle("Cencel", for: .normal)
        cancelBtn.setTitleColor(.link , for: .normal)
        cancelBtn.layer.cornerRadius = 10
        cancelBtn.addTarget(self, action: #selector (cancel), for: .touchDown)
        
        return cancelBtn
    }()
    
    let tweetbtn : UIButton = {
        let tweetbtn = UIButton()
        tweetbtn.frame = CGRect(x: 270, y: 70, width: 80, height: 30)
        tweetbtn.backgroundColor = #colorLiteral(red: 0.6620503664, green: 0.728490293, blue: 0.6658555269, alpha: 1)
        tweetbtn.setTitle("Tweet", for: .normal)
        tweetbtn.setTitleColor(.white, for: .normal)
        tweetbtn.layer.cornerRadius = 15
        tweetbtn.addTarget(self, action: #selector(addTweet), for: .touchDown)
        return tweetbtn
    }()

    
    
    // to return a user into Home Page
    
    @objc func cancel() {
        let homePage = HomePageVC()
        homePage.modalPresentationStyle = .fullScreen
        present(homePage, animated: true, completion: nil)
        
    }
    
    
      func sendTweet() {

      let tweet = tweetField.text
//         let tweetUser = Auth.auth().currentUser?.email{
         //Save data to Cloud Firestore
         db.collection("Tweets").addDocument(data: [
            "name": name,
            "content": tweet,
            "timeStamp" : FieldValue.serverTimestamp(),
            "email" : user?.email
           ]){ (error) in
              if let error = error{
               print(error)
              }else{
                // need the for DispatchQueue,data may be delayed because it comes from DB
                DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
              } // end DispatchQueue
              }// else
            }
//       } //end if
      }
    @objc func addTweet() {
        sendTweet()
    }


}
