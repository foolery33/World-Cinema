//
//  TagModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 27.03.2023.
//

import Foundation

struct TagModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case tagId = "tagId"
        case tagName = "tagName"
        case categoryName = "categoryName"
    }
    
    init(tagId: String, tagName: String, categoryName: String) {
        self.tagId = tagId
        self.tagName = tagName
        self.categoryName = categoryName
    }
    
    let tagId: String
    let tagName: String
    let categoryName: String
    
}
