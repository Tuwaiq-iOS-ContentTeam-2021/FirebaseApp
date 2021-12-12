//
//  Colors.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//

import UIKit


extension UIButton {
    open func setupButton(with title: String) {
        backgroundColor = .systemOrange
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 13
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.25
        translatesAutoresizingMaskIntoConstraints = false
    }
    open func setupButton(using image: String) {
        setImage(UIImage(systemName: image)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        backgroundColor = .systemOrange
        layer.borderColor = UIColor.white.cgColor
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false 
    }
}
