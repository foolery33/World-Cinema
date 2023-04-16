//
//  GetFirstTwoLettersOfChatNameUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 15.04.2023.
//

import Foundation

final class GetFirstTwoLettersOfChatNameUseCase {
    
    func getLetters(chatName: String) -> String {
        let components = chatName.components(separatedBy: .whitespaces)
        if components.count == 1 {
            return String(chatName.prefix(2)).uppercased()
        } else {
            return String(components[0].prefix(1)).uppercased() + String(components[1].prefix(1)).uppercased()
        }
    }
    
}
