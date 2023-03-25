//
//  RefreshTokenModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation

struct RefreshTokenModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refreshToken"
    }
    
    init (refreshToken: String) {
        self.refreshToken = refreshToken
    }
    
    let refreshToken: String
    
}
