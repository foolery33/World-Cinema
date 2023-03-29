//
//  MainScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import Foundation

class MainScreenViewModel {
    
    private var model = MainScreenModel()
    weak var coordinator: MainCoordinator!
    
    var inTrendMovies: [MovieModel] {
        get {
            model.inTrendMovies
        }
        set {
            model.inTrendMovies = newValue
        }
    }
    
    var lastViewMovies: [MovieModel] {
        get {
            model.lastViewMovies
        }
        set {
            model.lastViewMovies = newValue
        }
    }
    
    var newMovies: [MovieModel] {
        get {
            model.newMovies
        }
        set {
            model.newMovies = newValue
        }
    }
    
    var error: String {
        get {
            model.error
        }
        set {
            model.error = newValue
        }
    }
    
    func getInTrendMovies(completion: @escaping (Bool) -> Void) {
        MovieViewModel.shared.getMovies(queryParameter: "inTrend") { [weak self] result in
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
    
    func getLastViewMovies(completion: @escaping (Bool) -> Void) {
        MovieViewModel.shared.getMovies(queryParameter: "lastView") { [weak self] result in
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
    
    func getNewMovies(completion: @escaping (Bool) -> Void) {
        MovieViewModel.shared.getMovies(queryParameter: "new") { [weak self] result in
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
