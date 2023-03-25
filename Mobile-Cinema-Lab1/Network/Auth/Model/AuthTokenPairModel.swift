//
//  AuthTokenPairModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation

struct AuthTokenPairModel: Decodable {
    
    enum codingKeys: String, CodingKey {
        case accessToken = "accessToken"
    }
    
    init(accessToken: String, accessTokenExpiresIn: Int, refreshToken: String, refreshTokenExpiresIn: Int) {
        self.accessToken = accessToken
        self.accessTokenExpiresIn = accessTokenExpiresIn
        self.refreshToken = refreshToken
        self.refreshTokenExpiresIn = refreshTokenExpiresIn
    }
    
    let accessToken: String
    let accessTokenExpiresIn: Int
    let refreshToken: String
    let refreshTokenExpiresIn: Int
    
}
