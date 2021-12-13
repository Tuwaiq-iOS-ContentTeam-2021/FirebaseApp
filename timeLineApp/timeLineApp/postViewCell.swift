//
//  postViewCell.swift
//  timeLineApp
//
//  Created by Areej on 12/12/2021.
//

import UIKit

class postViewCell: UITableViewCell {
    
    @IBOutlet weak var emailOfUser: UILabel!
    @IBOutlet weak var nameofUser: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtPost: UILabel!
    @IBOutlet weak var imgPost: UIImageView!
    
    @IBOutlet weak var edit: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    

        // Configure the view for the selected state
    }

}
