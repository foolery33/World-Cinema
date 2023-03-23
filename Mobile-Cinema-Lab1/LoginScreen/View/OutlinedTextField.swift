//
//  OutlinedTextField.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class OutlinedTextField: UITextField {

    let padding = UIEdgeInsets(top: 13, left: 16, bottom: 13, right: 16)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func getOutlinedTextField(placeholderText: String, isSecured: Bool, selector: Selector) -> OutlinedTextField {
        let textField = OutlinedTextField()

        textField.textColor = UIColor.grayTextColor
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.isSecureTextEntry = isSecured
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayTextColor])
        
        textField.layer.borderColor = CGColor.grayColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        textField.addTarget(self, action: selector, for: .editingChanged)
        
        return textField
    }
    
}
