//
//  HomeTableViewCell.swift
//  TimeLineApp
//
//  Created by Abrahim MOHAMMED on 11/12/2021.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var descrabtionLable: UILabel!

    @IBOutlet weak var userNameLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
