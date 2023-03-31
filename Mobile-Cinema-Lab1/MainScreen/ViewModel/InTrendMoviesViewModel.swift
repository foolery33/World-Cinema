//
//  InTrendMoviesViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class InTrendMoviesViewModel {
    
    weak var coordinator: MainCoordinator?
    private var model = InTrendMoviesModel()
    private var movieRepository: MovieRepository
    
    init(coordinator: MainCoordinator, movieRepository: MovieRepository) {
        self.coordinator = coordinator
        self.movieRepository = movieRepository
    }
    
    var inTrendMovies: [MovieModel] {
        get {
            model.inTrendMovies
        }
        set {
            model.inTrendMovies = newValue
        }
    }
    
    var error: String = ""
    
    func getInTrendMovies(completion: @escaping (Bool) -> Void) {
        movieRepository.getMovies(queryParameter: "inTrend") { [weak self] result in
            switch result {
            case .success(let data):
                self?.inTrendMovies = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
