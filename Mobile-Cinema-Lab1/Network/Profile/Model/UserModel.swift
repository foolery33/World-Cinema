//
//  UserModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import Foundation

struct UserModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
        case avatar = "avatar"
    }
    
    init(userId: String, firstName: String, lastName: String, email: String, avatar: String? = nil) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.avatar = avatar
    }
    
    var userId: String
    var firstName: String
    var lastName: String
    var email: String
    var avatar: String?
    
}

