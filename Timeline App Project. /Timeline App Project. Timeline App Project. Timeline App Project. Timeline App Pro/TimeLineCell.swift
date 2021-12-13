//
//  TimeLineCell.swift
//  Timeline App Project. Timeline App Project. Timeline App Project. Timeline App Pro
//
//  Created by Qahtani's MacBook Pro on 12/11/21.
//

import UIKit

class TimeLineCell: UITableViewCell {
    
    @IBOutlet weak var likebutton: UIButton!
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var UserName: UILabel!
    
    @IBOutlet weak var Describtion: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeAction(_ sender: Any) {
        
        
       }
}
