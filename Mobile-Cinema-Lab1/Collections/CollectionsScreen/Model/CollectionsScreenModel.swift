//
//  CollectionsScreenModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation

struct CollectionsScreenModel {
    
    var collections: [CollectionModel] = []
    
    mutating func addNewCollection(newCollection: CollectionModel) {
        collections.append(newCollection)
    }
    
}
