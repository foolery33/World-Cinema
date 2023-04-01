//
//  EpisodeModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 01.04.2023.
//

import Foundation

struct EpisodeModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "episodeId"
        case name = "name"
        case description = "description"
        case director = "director"
        case stars = "stars"
        case year = "year"
        case images = "images"
        case runtime = "runtime"
        case preview = "preview"
        case filePath = "filePath"
    }
    
    init(episodeId: String, name: String, description: String, director: String, stars: [String], year: Int, images: [String], runtime: Int, preview: String, filePath: String) {
        self.episodeId = episodeId
        self.name = name
        self.description = description
        self.director = director
        self.stars = stars
        self.year = year
        self.images = images
        self.runtime = runtime
        self.preview = preview
        self.filePath = filePath
    }
    
    var episodeId: String
    var name: String
    var description: String
    var director: String
    var stars: [String]
    var year: Int
    var images: [String]
    var runtime: Int
    var preview: String
    var filePath: String
    
}
