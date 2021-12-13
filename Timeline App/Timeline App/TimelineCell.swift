//
//  TimelineCell.swift
//  Timeline App
//
//  Created by mac on 11/12/2021.
//

import UIKit

class TimelineCell: UITableViewCell {


    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var contentLable: UILabel!
    @IBOutlet weak var dateLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
