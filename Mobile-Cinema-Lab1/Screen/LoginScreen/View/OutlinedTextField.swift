//
//  OutlinedTextField.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class OutlinedTextField: UITextField {
    
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
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: self.isSecured ? Paddings.securedTextField : Paddings.textField)
    }
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let offset = Paddings.offset
        let width  = RegisterScreenView.Scales.passwordEyeSize
        let height = width
        let x = CGFloat(Int(bounds.width) - Int(width) - Int(offset))
        let y = self.bounds.height / 2 - RegisterScreenView.Scales.passwordEyeSize / 2
        let rightViewBounds = CGRect(x: x, y: y, width: width, height: height)
        return rightViewBounds
    }
    
    func getOutlinedTextField(text: String, placeholderText: String, selector: Selector) -> OutlinedTextField {
        let textField = OutlinedTextField(isSecured: self.isSecured)

        textField.text = text
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.redColor
        textField.font = UIFont.systemFont(ofSize: Scales.fontSize, weight: .regular)
        textField.isSecureTextEntry = self.isSecured

        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayTextColor])
        
        textField.layer.borderColor = CGColor.grayColor
        textField.layer.borderWidth = Scales.borderWidth
        textField.layer.cornerRadius = Scales.cornerRadius
        
        if(isSecured) {
            textField.rightView = passwordEye
            textField.rightViewMode = .always
        }
        
        textField.addTarget(self, action: selector, for: .editingChanged)
        
        return textField
    }
    
    private enum Paddings {
        static let offset = 16.0
        static let securedTextField = UIEdgeInsets(top: 13.0, left: 16.0, bottom: 13.0, right: 48.0)
        static let textField = UIEdgeInsets(top: 13.0, left: 16.0, bottom: 13.0, right: 16.0)
    }
    
    private enum Scales {
        static let fontSize = 14.0
        static let borderWidth = 1.0
        static let cornerRadius = 4.0
    }
    
}
