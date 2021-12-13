//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Nora on 08/05/1443 AH.
//

import UIKit

class TweetCell: UITableViewCell {

    static let identifier = "TweetCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(name)
        contentView.addSubview(content)
//        contentView.addSubview(timeStamp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
    super.layoutSubviews()
        
        name.frame = CGRect(x: 5, y: 15, width: 150, height: 20)
        content.frame = CGRect(x: 20, y: 40, width: 200, height: 30)
//        timeStamp.frame = CGRect(x: 30, y: 80, width: 80, height: 20)
        
        
    }

    
    
    // i did organized all views in Closures
    
    
    let name : UILabel = {
        let name = UILabel()
        name.textColor = #colorLiteral(red: 0.2984212935, green: 0.4633455873, blue: 0.401691407, alpha: 1)
        return name
    }()
    
    let content : UILabel = {
        let content = UILabel()
        content.textColor = #colorLiteral(red: 0.1448850334, green: 0.2240020931, blue: 0.1941880286, alpha: 1)
        return content
    }()
    
    let timeStamp : UILabel = {
        let timeStamp = UILabel()
        timeStamp.textColor = .black
        return timeStamp
    }()
 
}



