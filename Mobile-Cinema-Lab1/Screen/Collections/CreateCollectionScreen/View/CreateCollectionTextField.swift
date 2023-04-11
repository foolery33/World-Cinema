//
//  CreateCollectionTextField.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 05.04.2023.
//

import UIKit

class CreateCollectionTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Paddings.textField)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Paddings.textField)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Paddings.textField)
    }
    
    func getOutlinedTextField(text: String, placeholderText: String, selector: Selector) -> CreateCollectionTextField {
        let textField = CreateCollectionTextField()

        textField.text = text
        textField.autocapitalizationType = .none
        textField.textColor = UIColor.white
        textField.font = UIFont.systemFont(ofSize: Scales.fontSize, weight: .regular)

        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grayTextColor])
        
        textField.layer.borderColor = UIColor.darkGrayColor.cgColor
        textField.layer.borderWidth = Scales.borderWidth
        textField.layer.cornerRadius = Scales.cornerRadius
        
        textField.addTarget(self, action: selector, for: .editingChanged)
        
        return textField
    }
    
    private enum Paddings {
        static let offset = 16.0
        static let textField = UIEdgeInsets(top: 11.0, left: 16.0, bottom: 11.0, right: 16.0)
    }
    
    private enum Scales {
        static let fontSize = 14.0
        static let borderWidth = 1.0
        static let cornerRadius = 4.0
    }
    
}
