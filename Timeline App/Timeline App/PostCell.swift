//
//  PostCell.swift
//  Timeline App
//
//  Created by Abdullah AlRashoudi on 12/12/21.
//

import UIKit

class PostCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
