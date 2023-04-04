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
    
    init(collectionsRepository: CollectionsRepository) {
        self.collectionsRepository = collectionsRepository
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
    
}
