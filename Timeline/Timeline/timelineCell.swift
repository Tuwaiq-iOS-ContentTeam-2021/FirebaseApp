//
//  timelineCellTableViewCell.swift
//  Timeline
//
//  Created by Najla Talal on 12/10/21.
//

import UIKit
import Firebase
class timelineCell: UITableViewCell {

    @IBOutlet weak var userimage: timelineCell!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var postlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
