//
//  TimelineCellTableViewCell.swift
//  TimelineApp
//
//  Created by Mola on 11/12/2021.
//

import UIKit
import Firebase

class TimelineCell: UITableViewCell {

    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myPostText: UITextView!
    @IBOutlet weak var myEmail: UILabel!
    @IBOutlet weak var myImage1: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
// ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
//    let db = Firestore.firestore() // refrence
//    db.collection("Users")
//        .document("user")
//        .getDocuments()
//    {
//        (qurySnashot, err) in
//        if let error = err {
//            print(err?.localizedDescription)
//        }else{
//            for decument in qurySnashot!.documents{
//                let data = decument.data()
//                let xName = data["email"] as? String ?? "no email"
//            }
//        }
//    }
    // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setPost(post: Post){
        myPostText.text = post.postText
        myEmail.text = post.postEmail
        setImage(ImageUrl: post.postImage!)
    }
//    func setImage(postImage: UIImage){
//        myImage.image = postImage
//    }
    
//    func setImage(){
    func setImage(ImageUrl: String){

        let storageRef = Storage.storage().reference(forURL: "gs://timelineapp-3f532.appspot.com")
//        let postImageRef = storageRef.child(ImageUrl)
        let postImageRef = storageRef.child("images").child(ImageUrl)
        
//        postImageRef.getData(maxSize: 8 * 1024 * 1024) {
//            data, err in
//            if let error = err {
//                print("** cannot load image **", error.localizedDescription)
//            }else{
//                self.myImage.image = UIImage(data: data!)
//                print("** Image loaded sucssefuly **")
//            }
//        }
        //----
//        let storageRef = Storage.storage().reference()
//        let ref = storageRef.child("images")
//        myImage.sd_setImage(with: ref)
        //---
//        postImageRef.data(withMaxSize: 8 * 1024 * 1024){
//            data , error in
//            if let error = err {
//                print("** cannot load image **")
//            }else{
//                self.myImage.image = UIImage(data: data!)
//            }
        }
        
    }
