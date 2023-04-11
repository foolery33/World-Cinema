//
//  NewMoviesViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class NewMoviesViewModel {
    
    private var model = NewMoviesModel()
    weak var coordinator: MainCoordinator?
    private var movieRepository: MovieRepository
    
    init(coordinator: MainCoordinator, movieRepository: MovieRepository) {
        self.coordinator = coordinator
        self.movieRepository = movieRepository
    }
    
    var newMovies: [MovieModel] {
        get {
            model.newMovies
        }
        set {
            model.newMovies = newValue
        }
    }
    
    var error: String = ""
    
    func getNewMovies(completion: @escaping (Bool) -> Void) {
        movieRepository.getMovies(queryParameter: "new") { [weak self] result in
            switch result {
            case .success(let data):
                self?.newMovies = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
