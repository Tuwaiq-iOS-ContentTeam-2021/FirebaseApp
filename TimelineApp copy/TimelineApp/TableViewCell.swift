//
//  TableViewCell.swift
//  TimelineApp
//
//  Created by TAGHREED on 07/05/1443 AH.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var user: UILabel!
    
    @IBOutlet weak var textArea: UILabel!
    @IBOutlet weak var like: UIButton!
    
    @IBOutlet weak var share: UIButton!
    let heart = UIImage(systemName: "heart.circle")
    
    @IBAction func likeAction(_ sender: Any) {
        if  like.tintColor == .systemPink {
            
            like.setImage(heart, for: .normal)
            like.tintColor = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
        }else{
            var heart = UIImage(systemName: "heart.circle.fill")
            like.setImage(heart, for: .normal)
            like.tintColor = .systemPink
            
            
        }
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
    }
    
    
}
