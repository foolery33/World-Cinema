//
//  GetAgeLimitLabel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import UIKit

final class GetAgeLimitLabelUseCase {
    
    func getLabel(ageLimit: String) -> UILabel {
        let myLabel = UILabel()
        myLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        myLabel.text = ageLimit
        switch ageLimit {
        case "18+":
            myLabel.textColor = .redColor
        case "16+":
            myLabel.textColor = .color16
        case "12+":
            myLabel.textColor = .color12
        case "6+":
            myLabel.textColor = .color6
        case "0+":
            myLabel.textColor = .color0
        default:
            myLabel.textColor = .color0
        }
        return myLabel
    }
    
}
