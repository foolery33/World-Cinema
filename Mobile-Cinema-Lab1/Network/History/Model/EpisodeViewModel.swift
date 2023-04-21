//
//  EpisodeViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 21.04.2023.
//

import Foundation

struct EpisodeViewModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "episodeId"
        case movieId = "movieId"
        case episodeName = "episodeName"
        case movieName = "movieName"
        case preview = "preview"
        case filePath = "filePath"
        case time = "time"
    }
    
    init(episodeId: String, movieId: String, episodeName: String, movieName: String, preview: String, filePath: String, time: Int) {
        self.episodeId = episodeId
        self.movieId = movieId
        self.episodeName = episodeName
        self.movieName = movieName
        self.preview = preview
        self.filePath = filePath
        self.time = time
    }
    
    var episodeId: String
    var movieId: String
    var episodeName: String
    var movieName: String
    var preview: String
    var filePath: String
    var time: Int
    
}
