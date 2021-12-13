//
//  TweetCell.swift
//  Timeline
//
//  Created by Sahab Alharbi on 07/05/1443 AH.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var namelabel: UILabel!

    @IBOutlet weak var tweetlabel: UILabel!
    
    @IBOutlet weak var imageprofile: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
