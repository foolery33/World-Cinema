//
//  SaveCollectionListInDBUseCase.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 20.04.2023.
//

import Foundation
import RealmSwift

class SaveCollectionListInDBUseCase {
    
    var collectionsRepository: CollectionsRepository
    var collectionsDatabase: CollectionsDatabase
    
    init(collectionsRepository: CollectionsRepository, collectionsDatabase: CollectionsDatabase) {
        self.collectionsRepository = collectionsRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    func updateCollections(completion: @escaping (Bool) -> Void) {
        self.collectionsRepository.getCollections { result in
            switch result {
            case .success(let serverCollections):
                let dataBaseCollections = self.collectionsDatabase.getAllCollections()
                
                // Обновляем существующие коллекции в базе данных
                var newDataBaseCollections: [MovieCollection] = []
                
                for collection in serverCollections {
                    let currentCollection = self.collectionsDatabase.getCollectionById(id: collection.collectionId)
                    if currentCollection != nil {
                        newDataBaseCollections.append(currentCollection!)
                    }
                    else {
                        let newCollection = MovieCollection()
                        newCollection.id = collection.collectionId
                        newCollection.name = collection.name
                        newCollection.imageName = "Group 1"
                        newDataBaseCollections.append(newCollection)
                    }
                }
                
                // Удаляем несуществующие коллекции из базы данных
                self.removeExtraCollections(oldDB: dataBaseCollections, newDB: newDataBaseCollections)
                
                // Сохраняем (или обновляем) новые коллекции в базе данных
                for collection in newDataBaseCollections {
                    if self.collectionsDatabase.getCollectionById(id: collection.id) != nil {
                        self.collectionsDatabase.updateCollection(id: collection.id, name: collection.name, imageName: collection.imageName)
                    }
                    else {
                        self.collectionsDatabase.createCollection(id: collection.id, name: collection.name, imageName: collection.imageName)
                    }
                }
                print(serverCollections)
                // Сохраняем айди коллекции "Избранного"
                if newDataBaseCollections.isEmpty == false {
                    UserDataManager.shared.saveFavouritesCollectionId(id: newDataBaseCollections[0].id)
                }
                
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
    
    func removeExtraCollections(oldDB: [MovieCollection], newDB: [MovieCollection]) {
        // Выписываем айдишники коллекций в старой бд
        var oldIDs = [String]()
        for collection in oldDB {
            oldIDs.append(collection.id)
        }
        
        // Выписываем айдишники коллекций в актуальной бд
        var newIDs = [String]()
        for collection in newDB {
            newIDs.append(collection.id)
        }
        
        // Удаляем из бд коллекции, которых нет в актуальной бд
        for id in oldIDs {
            if newIDs.contains(id) == false {
                self.collectionsDatabase.deleteCollection(withId: id)
            }
        }
    }
    
    deinit {
        print("deinited")
    }
    
}
