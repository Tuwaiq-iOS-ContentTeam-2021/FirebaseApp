//
//  Post.swift
//  TimelineApp
//
//  Created by WjdanMo on 11/12/2021.
//

import Foundation
import UIKit

class Post{
    // MARK: text post
    
    let postContent : String
    
    init(postContent: String){
        self.postContent = postContent
    }
    
    // MARK: image post
    
//    let imageURL: String
//    let creationDate: Date
//        var key: String?
//        let imageHeight: CGFloat
//
//    var dictValue: [String : Any] {
//        let createdAgo = creationDate.timeIntervalSince1970
//
//        return ["image_url" : imageURL,
//                "image_height" : imageHeight,
//                "created_at" : createdAgo]
//    }
//
//    init(imageURL: String, imageHeight: CGFloat) {
//        self.imageURL = imageURL
//        self.imageHeight = imageHeight
//        self.creationDate = Date()
//    }
}
