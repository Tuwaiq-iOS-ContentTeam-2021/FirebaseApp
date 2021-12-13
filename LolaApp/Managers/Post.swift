
//
//  Post.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import Foundation


class Post {
    
    var postText = ""
    var postImageUrl = ""
    var postTimeIntervals = 0.0
    var postPersonUid = ""
    var postPersonEmail = ""
    var postPersonName = ""
    
    
    init(postText:String, postImageUrl:String, postTimeIntervals:Double, postPersonUid : String, postPersonName : String, postPersonEmail : String) {
        self.postText = postText
        self.postImageUrl = postImageUrl
        self.postTimeIntervals = postTimeIntervals
        self.postPersonUid = postPersonUid
        self.postPersonName = postPersonName
        self.postPersonEmail = postPersonEmail
    }
    
    convenience init(id: String, dict values: [AnyHashable:Any]) {
        
        let postText = values["post"] as? String ?? ""
        let postImageUrl = values["postImageUrl"] as? String ?? ""
        let postTimeIntervals = values["timeIntervals"] as? Double ?? 0.0
        let postPersonUid = values["uid"] as? String ?? ""
        let postPersonName = values["name"] as? String ?? ""
        let postPersonEmail = values["email"] as? String ?? ""
        
        
        self.init(postText: postText, postImageUrl: postImageUrl, postTimeIntervals: postTimeIntervals, postPersonUid:postPersonUid, postPersonName:postPersonName, postPersonEmail: postPersonEmail)
    }

    
    static func posts(dict:[AnyHashable:Any]) -> [String: Post] {
        var dic : [String: Post] = [:]
        for (key, valueDict) in dict {
            if let id = key as? String, let values = valueDict as? [AnyHashable:Any]{
                
                let postText = values["post"] as? String ?? ""
                let postImageUrl = values["imageUrl"] as? String ?? ""
                let postTimeIntervals = values["timeIntervals"] as? Double ?? 0.0
                let postPersonUid = values["uid"] as? String ?? ""
                let postPersonName = values["name"] as? String ?? ""
                let postPersonEmail = values["email"] as? String ?? ""
                
                
                let post = Post(postText: postText, postImageUrl: postImageUrl, postTimeIntervals: postTimeIntervals, postPersonUid: postPersonUid, postPersonName: postPersonName, postPersonEmail: postPersonEmail)
                dic[id] = post
            }
        }
        return dic
    }
    

}
