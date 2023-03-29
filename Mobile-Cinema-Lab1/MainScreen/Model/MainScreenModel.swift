//
//  MainScreenModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import Foundation

struct MainScreenModel {
    
    var inTrendMovies: [MovieModel] = [MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: [])]
    var newMovies: [MovieModel] = [MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: [])]
    var lastViewMovies: [MovieModel] = [MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: [])]
    var error: String = ""
}
