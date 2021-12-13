//
//  tweetImageTableViewCell.swift
//  SocialMediaApp
//
//  Created by Rayan Taj on 11/12/2021.
//

import UIKit

class tweetImageTableViewCell: UITableViewCell {
    
    @IBOutlet var profile: UIImageView!
    @IBOutlet var email: UILabel!
    @IBOutlet var content: UITextView!
    @IBOutlet var tweetImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
