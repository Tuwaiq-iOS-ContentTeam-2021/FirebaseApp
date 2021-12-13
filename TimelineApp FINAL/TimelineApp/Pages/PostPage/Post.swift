
import Foundation
import Firebase

class Post{
    var postText: String?
    var userUID: String?
    var postImage: String?
    var postEmail:String?

    init(postText: String, userUID: String, postImage: String,postEmail:String){
        self.postText = postText
        self.userUID = userUID
        self.postImage = postImage
        self.postEmail = postEmail
    }
}


struct Massages{
    var email:String?
    var text:String?
    
}
