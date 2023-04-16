//
//  MessageModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 13.04.2023.
//

import Foundation

struct MessageModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case messageId = "messageId"
        case creationDateTime = "creationDateTime"
        case authorId = "authorId"
        case authorName = "authorName"
        case authorAvatar = "authorAvatar"
        case text = "text"
    }
    
    init(messageId: String, creationDateTime: String, authorId: String? = nil, authorName: String, authorAvatar: String? = nil, text: String) {
        self.messageId = messageId
        self.creationDateTime = creationDateTime
        self.authorId = authorId
        self.authorName = authorName
        self.authorAvatar = authorAvatar
        self.text = text
    }
    
    var messageId: String
    var creationDateTime: String
    var authorId: String?
    var authorName: String
    var authorAvatar: String?
    var text: String
    
}
