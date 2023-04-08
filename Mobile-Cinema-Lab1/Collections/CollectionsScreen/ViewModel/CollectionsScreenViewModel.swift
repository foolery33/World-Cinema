//
//  CollectionsScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import Foundation

final class CollectionsScreenViewModel {
    
    private var model = CollectionsScreenModel()
    weak var coordinator: CollectionsCoordinator!
    private var collectionsRepository: CollectionsRepository
    var collectionsDatabase: CollectionsDatabase
    
    init(collectionsRepository: CollectionsRepository, collectionsDatabase: CollectionsDatabase) {
        self.collectionsRepository = collectionsRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    var collections: [CollectionModel] {
        get {
            model.collections
        }
        set {
            model.collections = newValue
        }
    }
    
    var error: String = ""
    
    func startListeningForChanges(on createCollectionScreenViewModel: CreateCollectionScreenViewModel) {
        createCollectionScreenViewModel.onCollectionCreated = { [weak self] newCollection in
            self?.model.addNewCollection(newCollection: newCollection)
            print(newCollection)
        }
    }
    
    func getCollections(completion: @escaping (Bool) -> Void) {
        collectionsRepository.getCollections { [weak self] result in
            switch result {
            case .success(let data):
                self?.collections = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func goToCreateCollectionScreen() {
        coordinator.goToCreateCollectionScreen()
    }
    
}
