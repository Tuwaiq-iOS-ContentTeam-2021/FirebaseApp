//
//  TweetCell.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//


import UIKit

class TweetCell: UICollectionViewCell {
    
    static let id = "1234567890"
    
    let tweetUserImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    let tweetImage: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 9
        img.clipsToBounds = true
        return img
    }()
    let tweetUserName: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    let tweetText: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        lbl.textAlignment = .left
        lbl.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return lbl
    }()
    
    let tweetDate: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .black.withAlphaComponent(0.57)
        lbl.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented") }
    
    
    private func setupView() {
        
        
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        tweetUserName.translatesAutoresizingMaskIntoConstraints     = false
        tweetUserImage.translatesAutoresizingMaskIntoConstraints    = false
        tweetText.translatesAutoresizingMaskIntoConstraints         = false
        tweetImage.translatesAutoresizingMaskIntoConstraints        = false
        tweetDate.translatesAutoresizingMaskIntoConstraints         = false
        contentView.addSubview(tweetUserImage)
        contentView.addSubview(tweetUserName)
        contentView.addSubview(tweetDate)
        contentView.addSubview(tweetText)
        contentView.addSubview(tweetImage)
       
        
      
        
        NSLayoutConstraint.activate([
        

            tweetUserImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            tweetUserImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            tweetUserImage.heightAnchor.constraint(equalToConstant: 25),
            tweetUserImage.widthAnchor.constraint(equalToConstant: 25),
            
            tweetUserName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            tweetUserName.leadingAnchor.constraint(equalTo: tweetUserImage.trailingAnchor, constant: 10),
            tweetUserName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            tweetDate.topAnchor.constraint(equalTo: tweetUserName.bottomAnchor, constant: 10),
            tweetDate.leadingAnchor.constraint(equalTo: tweetUserImage.trailingAnchor, constant: 10),
            tweetDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            tweetText.topAnchor.constraint(equalTo: tweetDate.bottomAnchor, constant: 10),
            tweetText.leadingAnchor.constraint(equalTo: tweetUserImage.trailingAnchor, constant: 10),
            tweetText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),


            tweetImage.topAnchor.constraint(equalTo: tweetText.bottomAnchor, constant: 16),
            tweetImage.leadingAnchor.constraint(equalTo: tweetUserImage.trailingAnchor, constant: 10),
            tweetImage.heightAnchor.constraint(equalToConstant: 125),
            tweetImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

}
