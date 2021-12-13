//
//  PostCell.swift
//  TimelineApp
//
//  Created by WjdanMo on 11/12/2021.
//

import UIKit

class PostCell: UITableViewCell {

    let post = UILabel()
    let profilePic = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        profilePic.image = UIImage(systemName: "person.circle")
        profilePic.tintColor = #colorLiteral(red: 0.02345971204, green: 0.03930909559, blue: 0.5252719522, alpha: 0.8470588235)
        profilePic.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        contentView.addSubview(profilePic)
        
        post.frame = CGRect(x: 80, y: 15, width: 200, height: 30)
        post.textColor = .black
        post.numberOfLines = 0
        contentView.addSubview(post)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
