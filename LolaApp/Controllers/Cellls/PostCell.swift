//
//  PostCell.swift
//  Lola App
//
//  Created by Lola M on 12/12/21.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet var imgPerson : UIImageView!
    @IBOutlet var txtPost : UITextView!
    @IBOutlet var lblUserName : UILabel!
    @IBOutlet var lblPostTime : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPerson.layer.cornerRadius = 
        imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        imgPerson.layer.masksToBounds = false
        self.layer.masksToBounds = false

    }
}
