//
//  OutlinedButton.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class OutlinedButton: UIButton {
    
    func getOutlinedButton(label: String, selector: Selector) -> OutlinedButton {
        let button = OutlinedButton(type: .system)
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Scales.fontSize, weight: .bold)
        button.setTitleColor(.redColor, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: Paddings.topContentPadding, left: Paddings.leadingContentPadding, bottom: Paddings.bottomContentPadding, right: Paddings.trailingContentPadding)
        button.layer.borderColor = CGColor.grayColor
        button.layer.borderWidth = Scales.borderWidth
        button.layer.cornerRadius = Scales.cornerRadius
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

    private enum Paddings {
        static let topContentPadding = 13.0
        static let bottomContentPadding = 13.0
        static let leadingContentPadding = 0.0
        static let trailingContentPadding = 0.0
    }
    
    private enum Scales {
        static let fontSize = 14.0
        static let borderWidth = 1.0
        static let cornerRadius = 4.0
    }
    
}
