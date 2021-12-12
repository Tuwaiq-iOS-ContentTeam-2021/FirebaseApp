//
//  TimeLineTableViewCell.swift
//  TimeLineTask
//
//  Created by AlDanah Aldohayan on 11/12/2021.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var thePostLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
