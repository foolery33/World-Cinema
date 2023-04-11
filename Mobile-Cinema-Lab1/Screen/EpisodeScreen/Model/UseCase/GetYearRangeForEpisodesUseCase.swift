//
//  GetPosterByMovieIdUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation

final class GetYearRangeForEpisodesUseCase {
    
    func getRange(episodes: [EpisodeModel]) -> String {
        
        var minim = episodes[0].year
        var maxim = episodes[0].year
        
        for i in 1..<episodes.count {
            if(episodes[i].year > maxim) {
                maxim = episodes[i].year
            }
            if(episodes[i].year < minim) {
                minim = episodes[i].year
            }
        }
        
        return "\(minim)-\(maxim)"
    }
    
}
