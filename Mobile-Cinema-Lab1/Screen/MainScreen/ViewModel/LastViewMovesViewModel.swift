//
//  LastViewMovesViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 30.03.2023.
//

import Foundation

class LastViewMoviesViewModel {
    
    weak var coordinator: MainCoordinator?
    private var model = LastViewMoviesModel()
    private var movieRepository: MovieRepository
    private var historyRepository: HistoryRepository
    
    init(coordinator: MainCoordinator, movieRepository: MovieRepository, historyRepository: HistoryRepository) {
        self.coordinator = coordinator
        self.movieRepository = movieRepository
        self.historyRepository = historyRepository
    }
    
    var lastViewMovies: [MovieModel] {
        get {
            model.lastViewMovies
        }
        set {
            model.lastViewMovies = newValue
        }
    }
    
    var history: [EpisodeViewModel] {
        get {
            model.history
        }
        set {
            model.history = newValue
        }
    }
    
    var episode: EpisodeModel {
        get {
            model.episode
        }
        set {
            model.episode = newValue
        }
    }
    
    var error: String = ""
    var episodesYearRange: String = ""
    
    func goToEpisodeScreen() {
        self.coordinator?.goToEpisodeScreen(yearRange: self.episodesYearRange, episode: self.episode, movie: self.lastViewMovies[0])
    }
    
    func getEpisode(completion: @escaping (Bool) -> Void) {
        self.movieRepository.getMovieEpisodesById(movieId: self.lastViewMovies[0].movieId) { [weak self] result in
            switch result {
            case .success(let data):
                let episodes = data
                self?.episodesYearRange = GetYearRangeForEpisodesUseCase().getRange(episodes: episodes)
                // Ищем и сохраняем эпизод, на который будем переходить
                for currentEpisode in episodes {
                    if currentEpisode.episodeId == self?.history[0].episodeId {
                        self?.episode = currentEpisode
                        break
                    }
                }
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
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
    
    func getHistory(completion: @escaping (Bool) -> Void) {
        historyRepository.getHistory() { [weak self] result in
            switch result {
            case .success(let data):
                self?.history = data
                if self?.lastViewMovies.isEmpty == false {
                    for movie in self!.lastViewMovies {
                        if movie.movieId == self?.history[0].movieId {
                            self?.lastViewMovies[0] = movie
                        }
                    }
                }
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
