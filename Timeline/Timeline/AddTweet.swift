//
//  AddTweet.swift
//  Timeline
//
//  Created by Sahab Alharbi on 06/05/1443 AH.
//

import UIKit
import Firebase

class AddTweet: UIViewController, UITextViewDelegate {
    let firestore = Firestore.firestore()
    let userID = Auth.auth().currentUser?.uid
    let name = Auth.auth().currentUser?.displayName
    //    var name = ""
    var userName = ""
    @IBOutlet weak var textview: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textview.delegate = self
        textview.text = "What's happening?"
        textview.textColor = UIColor.lightGray
        textViewDidBeginEditing(textview)
        textViewDidEndEditing(textview)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTweetButton(_ sender: Any) {
        firestore.collection("Tweets")
            .addDocument(data: [
                "tweet" : textview.text!,
                "userid" :userID,
                "name" : userName
            ]) { (error) in
                if let e = error {
                    print(e)
                } else {
                    print("Successfully saved data")
                }
            }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabbar") as! TabBar
        self.present(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func textViewDidBeginEditing(_ textview: UITextView) {
        if textview.textColor == UIColor.lightGray {
            textview.text = ""
            textview.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textview: UITextView) {
        if textview.text.isEmpty {
            textview.text = "What's happening?"
            textview.textColor = UIColor.lightGray
        }
    }
}
