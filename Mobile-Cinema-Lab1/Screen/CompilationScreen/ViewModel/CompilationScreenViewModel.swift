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
    
    var movies: [MovieModel] {
        get {
            model.movies
        }
        set {
            model.movies = newValue
        }
    }
    
    var error: String = ""
    
    init(movieRepository: MovieRepository, collectionsRepository: CollectionsRepository) {
        self.movieRepository = movieRepository
        self.collectionsRepository = collectionsRepository
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
    
}
