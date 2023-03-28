//
//  ChatModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 28.03.2023.
//

import Foundation

struct ChatModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case chatId = "chatId"
        case chatName = "chatName"
    }
    
    init(chatId: String, chatName: String) {
        self.chatId = chatId
        self.chatName = chatName
    }
    
    let chatId: String
    let chatName: String
}
