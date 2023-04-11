//
//  LastViewMovesViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class LastViewMoviesViewModel {
    
    private var model = LastViewMoviesModel()
    private var movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    var lastViewMovies: [MovieModel] {
        get {
            model.lastViewMovies
        }
        set {
            model.lastViewMovies = newValue
        }
    }
    
    var error: String = ""
    
    func getLastViewMovies(completion: @escaping (Bool) -> Void) {
        movieRepository.getMovies(queryParameter: "lastView") { [weak self] result in
            switch result {
            case .success(let data):
                self?.lastViewMovies = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
