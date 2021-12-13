//
//  Struct.swift
//  Timeline
//
//  Created by Najla Talal on 12/12/21.
//

import Foundation
import Firebase

struct Users {
    var name:String
    var id:String
    var post:String
    init(name:String,id:String,post:String){
        self.name = name
        self.id = id
        self.post = post
    }
}
