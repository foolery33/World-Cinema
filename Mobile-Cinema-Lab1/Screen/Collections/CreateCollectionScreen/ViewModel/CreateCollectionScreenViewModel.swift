//
//  CreateCollectionScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 05.04.2023.
//

import Foundation

final class CreateCollectionScreenViewModel {
    
    weak var coordinator: CollectionsCoordinator!
    private var collectionsRepository: CollectionsRepository
    var collectionsDatabase: CollectionsDatabase
    
    var collectionName: String = ""
    var iconName: String = "Group 1"
    var error: String = ""
    
    init(collectionsRepository: CollectionsRepository, collectionsDatabase: CollectionsDatabase) {
        self.collectionsRepository = collectionsRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    func goBackToCreateCollectionScreen() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
    var onCollectionCreated: ((CollectionModel) -> Void)?
    
    func createCollection(collectionName: String, completion: @escaping (Bool) -> Void) {
        collectionsRepository.createCollection(collectionName: collectionName) { [weak self] result in
            switch result {
            case .success(let data):
                self?.onCollectionCreated?(data)
                self?.collectionsDatabase.createCollection(id: data.collectionId, name: data.name, imageName: self?.iconName ?? "Group 1")
//                CollectionsManager.shared.setCollection(collectionId: data.collectionId, imageName: self?.iconName ?? "Group 1")
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
