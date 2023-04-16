//
//  CommentModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 12.04.2023.
//

import Foundation

struct CommentModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case commentId = "commentId"
        case creationDateTime = "creationDateTime"
        case authorName = "authorName"
        case authorAvatar = "authorAvatar"
        case text = "text"
    }
    
    init(commentId: String, creationDateTime: String, authorName: String, authorAvatar: String? = nil, text: String) {
        self.commentId = commentId
        self.creationDateTime = creationDateTime
        self.authorName = authorName
        self.authorAvatar = authorAvatar
        self.text = text
    }
    
    var commentId: String
    var creationDateTime: String
    var authorName: String
    var authorAvatar: String?
    var text: String
    
}
