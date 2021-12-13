//
//  TableViewCell.swift
//  FirebaseApp
//
//  Created by Ahmad MacBook on 10/12/2021.
//

import UIKit
import Firebase

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testText: UILabel!
    
    @IBOutlet weak var testText2: UILabel!
    
    @IBOutlet weak var likeOutlet: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func likeAction(_ sender: Any) {
        
        likeOutlet.tintColor = .red
        likeOutlet.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
