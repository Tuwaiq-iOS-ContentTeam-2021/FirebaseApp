//
//  CustomTextFields.swift
//  Twitterrr
//
//  Created by Taraf Bin suhaim on 06/05/1443 AH.
//


import UIKit

extension UITextField {
    open func setupTextField(with placeholder: NSAttributedString) {
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 13
        layer.borderWidth = 0.25
        layer.borderColor = UIColor.label.withAlphaComponent(0.5).cgColor
        clipsToBounds = true
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        attributedPlaceholder = placeholder
        tintColor = .label
        textColor = .label
        translatesAutoresizingMaskIntoConstraints = false 
    }
}
extension UITextView {
    open func setupTextView() {
        backgroundColor = .clear
        autocorrectionType = .no
        layer.cornerRadius = 13
        layer.borderWidth = 0.25
        layer.borderColor = UIColor.label.withAlphaComponent(0.5).cgColor
        clipsToBounds = true
        tintColor = .systemOrange
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
