//
//  EpisodeTimeModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 12.04.2023.
//

import Foundation

struct EpisodeTimeModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case timeInSeconds = "timeInSeconds"
    }
    
    init(timeInSeconds: Int? = nil) {
        self.timeInSeconds = timeInSeconds
    }
    
    var timeInSeconds: Int?
    
}
