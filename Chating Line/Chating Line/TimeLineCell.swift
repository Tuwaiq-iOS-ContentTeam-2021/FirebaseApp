//
//  TimeLineCell.swift
//  Chating Line
//
//  Created by Wejdan Alkhaldi on 07/05/1443 AH.
//

import UIKit
import Firebase
class TimeLineCell: UITableViewCell {
    var buttonLike : Bool = false
    
    @IBOutlet weak var labelEmail: UILabel!
    
 
    @IBOutlet weak var labelDesc: UILabel!
    
    @IBOutlet weak var likeoutllet: UIButton!
    override func awakeFromNib() {
        
        super.awakeFromNib()
       
    }

    @IBAction func like(_ sender: Any) {
        if buttonLike == false{
            likeoutllet.setImage(UIImage(systemName: "heart"), for: .normal)
            buttonLike = true
            
        }else{
            likeoutllet.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red), for: .normal)
            buttonLike = false
           
           
                
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
       
        
        

        
        
        
    }
    

