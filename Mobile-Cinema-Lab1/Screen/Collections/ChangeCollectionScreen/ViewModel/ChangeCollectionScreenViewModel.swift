//
//  ChangeCollectionScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 09.04.2023.
//

import Foundation

protocol DeleteCollectionDelegate {
    func deleteCollection(collectionId: String) -> Void
}
protocol ChangeCollectionNameDelegate {
    func changeName(collectionId: String, newName: String) -> Void
}

final class ChangeCollectionScreenViewModel {
    
    weak var coordinator: CollectionsCoordinator?
    var collection: CollectionModel
    var collectionsDatabase: CollectionsDatabase
    private var collectionsRepository: CollectionsRepository
    private var deleteCollectionDelegate: DeleteCollectionDelegate
    private var changeCollectionNameDelegate: ChangeCollectionNameDelegate
    
    var collectionName: String = ""
    var iconName: String = "Group 1"
    var error: String = ""
    
    init(collection: CollectionModel, collectionsDatabase: CollectionsDatabase, collectionsRepository: CollectionsRepository, deleteCollectionDelegate: DeleteCollectionDelegate, changeCollectionNameDelegate: ChangeCollectionNameDelegate) {
        self.collection = collection
        self.collectionsDatabase = collectionsDatabase
        self.collectionsRepository = collectionsRepository
        self.deleteCollectionDelegate = deleteCollectionDelegate
        self.changeCollectionNameDelegate = changeCollectionNameDelegate
    }
    
    func goBackToCollectionScreen() {
        self.coordinator?.navigationController.popToRootViewController(animated: true)
    }
    
    func getIconName() -> String {
        return self.collectionsDatabase.getCollectionById(id: self.collection.collectionId)?.imageName ?? "Group 1"
    }
    
    func changeCollectionName() {
        self.changeCollectionNameDelegate.changeName(collectionId: self.collection.collectionId, newName: self.collectionName)
        self.collectionsDatabase.updateCollection(id: self.collection.collectionId, name: self.collectionName, imageName: self.iconName)
    }
    
    func deleteCollection(collectionId: String, completion: @escaping (Bool) -> Void) {
        collectionsRepository.deleteCollection(collectionId: collectionId) { [weak self] result in
            switch result {
            case .success:
                completion(true)
                self?.deleteCollectionDelegate.deleteCollection(collectionId: collectionId)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
