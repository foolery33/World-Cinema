//
//  MovieModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 27.03.2023.
//

import Foundation

struct MovieModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movieId"
        case name = "name"
        case description = "description"
        case age = "age"
        case chatInfo = "chatInfo"
        case imageUrls = "imageUrls"
        case poster = "poster"
        case tags = "tags"
    }
    
    init(movieId: String, name: String, description: String, age: String, chatInfo: ChatModel, imageUrls: [String], poster: String, tags: [TagModel]) {
        self.movieId = movieId
        self.name = name
        self.description = description
        self.age = age
        self.chatInfo = chatInfo
        self.imageUrls = imageUrls
        self.poster = poster
        self.tags = tags
    }
    
    let movieId: String
    let name: String
    let description: String
    let age: String
    let chatInfo: ChatModel
    let imageUrls: [String]
    let poster: String
    let tags: [TagModel]
    
}
