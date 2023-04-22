//
//  CompilationScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 10.04.2023.
//

import Foundation

final class CompilationScreenViewModel {
    
    weak var coordinator: CompilationCoordinator?
    private var model = CompilationScreenModel()
    private var movieRepository: MovieRepository
    private var collectionsRepository: CollectionsRepository
    private var collectionsDatabase: CollectionsDatabase
    
    var movies: [MovieModel] {
        get {
            model.movies
        }
        set {
            model.movies = newValue
        }
    }
    
    var error: String = ""
    
    init(movieRepository: MovieRepository, collectionsRepository: CollectionsRepository, collectionsDatabase: CollectionsDatabase) {
        self.movieRepository = movieRepository
        self.collectionsRepository = collectionsRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    func goToMovieScreen(movie: MovieModel) {
        self.coordinator?.goToMovieScreen(movie: movie)
    }
    
    func getCompilaiton(completion: @escaping (Bool) -> Void) {
        movieRepository.getMovies(queryParameter: "compilation") { [weak self] result in
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
    
    func dislikeMovie(movieId: String, completion: @escaping (Bool) -> Void) {
        movieRepository.dislikeMovie(movieId: movieId) { [weak self] result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func addToFavourites(collectionId: String, movieId: String, completion: @escaping (Bool) -> Void) {
        collectionsRepository.addToCollection(collectionId: collectionId, movieId: movieId) { [weak self] result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func getFavouriteCollection(completion: @escaping (Bool) -> Void) {
        collectionsRepository.getCollections { [weak self] result in
            switch result {
            case .success(let data):
                let collections = data
                // Сохраняем id коллекции "Избранное"
                UserDataManager.shared.saveFavouritesCollectionId(id: collections[0].collectionId)
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
