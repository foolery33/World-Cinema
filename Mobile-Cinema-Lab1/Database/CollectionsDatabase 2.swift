//
//  MovieCollectionRepository.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 07.04.2023.
//

import Foundation
import RealmSwift

final class CollectionsDatabase {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // MARK: - Collection
    
    func createCollection(id: String, name: String, imageName: String) {
        let collection = MovieCollection()
        collection.id = id
        collection.name = name
        collection.imageName = imageName
        
        try? realm.write {
            realm.add(collection)
        }
    }
    
    func updateCollection(id: String, name: String, imageName: String) {
        if let collection = getCollectionById(id: id) {
            try? realm.write {
                collection.name = name
                collection.imageName = imageName
            }
        }
    }
    
    func deleteCollection(withId id: String) {
        if let collection = getCollectionById(id: id) {
            try? realm.write {
                realm.delete(collection)
            }
        }
    }
    
    func getAllCollections() -> [MovieCollection] {
        return Array(realm.objects(MovieCollection.self))
    }
    
    func getCollectionById(id: String) -> MovieCollection? {
        return realm.object(ofType: MovieCollection.self, forPrimaryKey: id)
    }
    
}
