//
//  MovieScreenModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import Foundation

struct MovieScreenModel {
    
    var movie: MovieModel = MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: "", lastMessage: MessageModel(messageId: "", creationDateTime: "", authorName: "", text: "")), imageUrls: [], poster: "", tags: [])
    var episodes: [EpisodeModel] = []
    
}
