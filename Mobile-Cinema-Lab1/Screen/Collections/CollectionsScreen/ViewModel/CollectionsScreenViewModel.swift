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
                for i in 0..<(self?.collections.count ?? 0) {
                    // Сохраняем id коллекции "Избранное"
                    if i == 0 {
                        UserDataManager.shared.saveFavouritesCollectionId(id: self?.collections[i].collectionId ?? "")
                    }
                    let collectionName = self?.collectionsDatabase.getCollectionById(id: self?.collections[i].collectionId ?? "")?.name ?? self?.collections[i].name ?? "Избранное"
                    self?.collections[i].name = collectionName
                }
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func goToCollectionScreen(collection: CollectionModel) {
        coordinator.goToCollectionScreen(collection: collection)
    }
    
    func goToCreateCollectionScreen() {
        coordinator.goToCreateCollectionScreen()
    }
    
}

extension CollectionsScreenViewModel: DeleteCollectionDelegate {
    func deleteCollection(collectionId: String) {
        for (index, collection) in self.collections.enumerated() {
            if collection.collectionId == collectionId {
                self.collections.remove(at: index)
                break
            }
        }
        self.collectionsDatabase.deleteCollection(withId: collectionId)
    }
}

extension CollectionsScreenViewModel: ChangeCollectionNameDelegate {
    func changeName(collectionId: String, newName: String) {
        for i in 0..<self.collections.count {
            if(collections[i].collectionId == collectionId) {
                self.collections[i].name = newName
                break
            }
        }
    }
}
