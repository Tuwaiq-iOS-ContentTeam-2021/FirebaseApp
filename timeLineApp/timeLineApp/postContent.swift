//
//  postContent.swift
//  timeLineApp
//
//  Created by Areej on 12/12/2021.
//

import Foundation
import UIKit
struct Posts{
    var name : String
    var textPost: String
    var emailaccount: String
    var profileimageURL : String?
    init(_ name : String,_ textPost: String, _ emailaccount : String){
//        , _ imgPost:UIImage 
        self.name = name
        self.textPost = textPost
        self.emailaccount = emailaccount
//        self.imgPost = imgPost
    }
}
