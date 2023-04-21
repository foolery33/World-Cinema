//
//  FilledButton.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class FilledButton: UIButton {

    func getFilledButton(label: String, selector: Selector?) -> FilledButton {
        let button = FilledButton(type: .system)
        button.layer.backgroundColor = R.color.redColor()?.cgColor
        button.setTitle(label, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: Paddings.topContentPadding, left: Paddings.leadingContentPadding, bottom: Paddings.bottomContentPadding, right: Paddings.trailingContentPadding)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Scales.fontSize, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Scales.cornerRadius
        if let selector {
            button.addTarget(self, action: selector, for: .touchUpInside)
        }
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
        static let cornerRadius = 4.0
    }
    
}
