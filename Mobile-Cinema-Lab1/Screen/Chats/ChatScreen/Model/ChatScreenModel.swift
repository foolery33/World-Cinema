//
//  ChatScreenModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

struct ChatScreenModel {
    
    var messages: [MessageModel] = []
    var groupedMessages: [[MessageModel]] = [[]]
    
    mutating func addMessage(message: MessageModel) {
        messages.append(message)
    }
    
}
