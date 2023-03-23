//
//  FilledButton.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import UIKit

class FilledButton: UIButton {

    func getFilledButton(label: String, selector: Selector) -> FilledButton {
        let button = FilledButton(type: .system)
        button.layer.backgroundColor = CGColor.redColor
        button.setTitle(label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: selector, for: .touchUpInside)
        return button
    }

}
