//
//  LastViewMoviesModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

struct LastViewMoviesModel {
    
    var lastViewMovies: [MovieModel] = []
    var history: [EpisodeViewModel] = []
    var episode: EpisodeModel = EpisodeModel(episodeId: "", name: "", description: "", director: "", stars: [], year: 0, images: [], runtime: 0, preview: "", filePath: "")
    
}
