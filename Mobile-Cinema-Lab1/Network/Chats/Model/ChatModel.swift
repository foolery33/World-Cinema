//
//  ChatModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

struct ChatModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case chatId = "chatId"
        case chatName = "chatName"
        case lastMessage = "lastMessage"
    }
    
    init(chatId: String, chatName: String, lastMessage: MessageModel? = nil) {
        self.chatId = chatId
        self.chatName = chatName
        self.lastMessage = lastMessage
    }
    
    var chatId: String
    var chatName: String
    var lastMessage: MessageModel?
    
}
