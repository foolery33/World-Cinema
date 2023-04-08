//
//  MovieCollection.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 07.04.2023.
//

import RealmSwift
import Foundation

final class MovieCollection: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageName: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
