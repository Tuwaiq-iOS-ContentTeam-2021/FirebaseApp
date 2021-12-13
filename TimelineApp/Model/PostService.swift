//
//  PostService.swift
//  TimelineApp
//
//  Created by WjdanMo on 11/12/2021.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase

struct PostService {
    static func create(for image: UIImage) {
        let imageRef = Storage.storage().reference().child("test_image.jpg")
        StorageService.uploadImage(image, at: imageRef) { (downloadURL) in
            guard let downloadURL = downloadURL else {
                return
            }

            let urlString = downloadURL.absoluteString
            
//            let vc = HomeVC()
//            vc.postsArray.append(Post(imageURL: urlString,
//                                          creationDate: Date()))
            
            print("image url: \(urlString)")
        }
    }
    
    static func create(_ sender : String , _ text : String){
        
    }
    
    private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
       
//        let currentUser = User.current

//        let post = Post(imageURL: urlString, imageHeight: aspectHeight)

//        let dict = post.dictValue

//        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()

//        postRef.updateChildValues(dict)
        
    }
}
