//
//  ForMeMoviesViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class ForMeMoviesViewModel {
    
    weak var coordinator: MainCoordinator?
    private var model = ForMeMoviesModel()
    private var movieRepository: MovieRepository
    
    init(coordinator: MainCoordinator, movieRepository: MovieRepository) {
        self.coordinator = coordinator
        self.movieRepository = movieRepository
    }
    
    var forMeMovies: [MovieModel] {
        get {
            model.forMeMovies
        }
        set {
            model.forMeMovies = newValue
        }
    }
    
    var error: String = ""
    
    func getForMeMovies(completion: @escaping (Bool) -> Void) {
        movieRepository.getMovies(queryParameter: "forMe") { [weak self] result in
            switch result {
            case .success(let data):
                self?.forMeMovies = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
