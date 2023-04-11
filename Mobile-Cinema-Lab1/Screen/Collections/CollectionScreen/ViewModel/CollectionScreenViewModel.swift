//
//  CollectionScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 08.04.2023.
//

import Foundation

final class CollectionScreenViewModel {
    
    weak var coordinator: CollectionsCoordinator?
    private var model = CollectionScreenModel()
    private var collectionsRepository: CollectionsRepository
    var collection: CollectionModel
    
    var movies: [MovieModel] {
        get {
            model.movies
        }
        set {
            model.movies = newValue
        }
    }
    
    var error: String = ""
    
    init(collectionsRepository: CollectionsRepository, collection: CollectionModel) {
        self.collectionsRepository = collectionsRepository
        self.collection = collection
    }
    
    func goToMovieScreen(movie: MovieModel) {
        self.coordinator?.goToMovieScreen(movie: movie)
    }
    
    func goBackToCollectionsScreen() {
        self.coordinator?.navigationController.popViewController(animated: true)
    }
    
    func goToChangeCollectionScreen(collection: CollectionModel) {
        self.coordinator?.goToChangeCollectionScreen(collection: self.collection)
    }
    
    func getMoviesFromCollection(collectionId: String, completion: @escaping (Bool) -> Void) {
        collectionsRepository.getMoviesFromCollection(collectionId: collectionId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.movies = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
