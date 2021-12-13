//
//  TextfieldsDesign.swift
//  TwitterApp
//
//  Created by Aisha Al-Qarni on 12/12/2021.
//

import UIKit

class TextfieldsDesign: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        customTextfield()
    }
    func customTextfield (){
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = .gray
        addSubview(underLineView)
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            underLineView.heightAnchor.constraint(equalToConstant: 1 )
        ])
    }
}

extension UITextField{
    @IBInspectable var placeholderColor: UIColor? {
        get {return self.placeholderColor}
        set {self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : newValue!])}
    }
}
