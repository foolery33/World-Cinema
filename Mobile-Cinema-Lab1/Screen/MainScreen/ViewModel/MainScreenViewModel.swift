//
//  MainScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import Foundation

class MainScreenViewModel {
    
    weak var coordinator: MainCoordinator!
    private var model = MainScreenModel()
    var coverRepository: CoverRepository
    
    init(coverRepository: CoverRepository) {
        self.coverRepository = coverRepository
    }
    
    var cover: CoverModel {
        get {
            model.cover
        }
        set {
            model.cover = newValue
        }
    }
    
    var error: String = ""
    
    lazy var inTrendMoviesViewModel = InTrendMoviesViewModel(coordinator: self.coordinator, movieRepository: MovieRepositoryImplementation())
    lazy var lastViewMoviesViewModel = LastViewMoviesViewModel(coordinator: self.coordinator, movieRepository: MovieRepositoryImplementation(), historyRepository: HistoryRepositoryImplementation())
    lazy var newMoviesViewModel = NewMoviesViewModel(coordinator: self.coordinator, movieRepository: MovieRepositoryImplementation())
    lazy var forMeMoviesViewModel = ForMeMoviesViewModel(coordinator: self.coordinator, movieRepository: MovieRepositoryImplementation())
    
    func getCover(completion: @escaping (Bool) -> Void) {
        coverRepository.getCover { [weak self] result in
            switch result {
            case .success(let data):
                self?.cover = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
