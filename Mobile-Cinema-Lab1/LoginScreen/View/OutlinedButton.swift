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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.redColor, for: .normal)
        button.layer.borderColor = CGColor.grayColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

}
