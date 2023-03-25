//
//  OutlinedTextField.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class OutlinedTextField: UITextField {
    
    let textFieldPadding = UITextFieldPaddings.textField
    let securedTextFieldPaddins = UITextFieldPaddings.securedTextField
    let isSecured: Bool
    let passwordEye: UIButton?
    
    init(isSecured: Bool, passwordEye: UIButton? = nil) {
        self.isSecured = isSecured
        self.passwordEye = passwordEye
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        if(isSecured) {
            return bounds.inset(by: securedTextFieldPaddins)
        }
        else {
            return bounds.inset(by: textFieldPadding)
        }
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        if(isSecured) {
            return bounds.inset(by: securedTextFieldPaddins)
        }
        else {
            return bounds.inset(by: textFieldPadding)
        }
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        if(isSecured) {
            return bounds.inset(by: securedTextFieldPaddins)
        }
        else {
            return bounds.inset(by: textFieldPadding)
        }
    }
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = UITextFieldPaddings.padding
        let width  = UITextFieldPaddings.passwordEyeSize
        let height = width
        let x = CGFloat(Int(bounds.width) - Int(width) - Int(offset))
        let y = CGFloat(Int(bounds.height / 4))
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
    func getOutlinedTextField(text: String, placeholderText: String, selector: Selector) -> OutlinedTextField {
        let textField = OutlinedTextField(isSecured: self.isSecured)

        textField.text = text
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.redColor
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        textField.isSecureTextEntry = self.isSecured
        
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayTextColor])
        
        textField.layer.borderColor = CGColor.grayColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 4
        
        if(isSecured) {
            textField.rightView = passwordEye
            textField.rightViewMode = .always
        }
        
        textField.addTarget(self, action: selector, for: .editingChanged)
        
        return textField
    }
    
}
