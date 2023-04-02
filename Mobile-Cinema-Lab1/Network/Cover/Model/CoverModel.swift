//
//  CoverModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation

struct CoverModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case backgroundImage = "backgroundImage"
        case foregroundImage = "foregroundImage"
    }
    
    init(backgroundImage: String, foregroundImage: String) {
        self.backgroundImage = backgroundImage
        self.foregroundImage = foregroundImage
    }
    
    var backgroundImage: String
    var foregroundImage: String
    
}
