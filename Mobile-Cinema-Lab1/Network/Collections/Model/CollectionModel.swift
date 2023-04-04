//
//  CollectionModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation

struct CollectionModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case collectionId = "collectionId"
        case name = "name"
    }
    
    init(collectionId: String, name: String) {
        self.collectionId = collectionId
        self.name = name
    }
    
    var collectionId: String
    var name: String
    
}
