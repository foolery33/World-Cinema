//
//  MovieScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 31.03.2023.
//

import Foundation
import UIKit

final class MovieScreenViewModel {
    
    weak var coordinator: MovieToEpisodeNavigationProtocol!
    private var model = MovieScreenModel()
    private var movieRepository: MovieRepository

    private let getAgeLimitUseCase: GetAgeLimitLabelUseCase
    private let getGenresListFromTagsUseCase: GetGenresListFromTagsUseCase

    var movie: MovieModel {
        get {
            model.movie
        }
        set {
            model.movie = newValue
        }
    }
    
    var episodes: [EpisodeModel] {
        get {
            model.episodes
        }
        set {
            model.episodes = newValue
        }
    }
    
    var error: String = ""
    
    init(movieRepository: MovieRepository,
         getAgeLimitUseCase: GetAgeLimitLabelUseCase,
         getGenresListFromTagsUseCase: GetGenresListFromTagsUseCase
    ) {
        self.movieRepository = movieRepository
        self.getAgeLimitUseCase = getAgeLimitUseCase
        self.getGenresListFromTagsUseCase = getGenresListFromTagsUseCase
    }

    func backToMainScreen() {
        let coordinator = self.coordinator as! Coordinator
        coordinator.navigationController.popViewController(animated: true)
    }
    
    func getMovieEpisodesById(movieId: String, completion: @escaping (Bool) -> Void) {
        movieRepository.getMovieEpisodesById(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.episodes = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func goToChatScreen(chat: ChatModel) {
        self.coordinator.goToChatScreen(chat: chat)
    }

    func getAgeLimit() -> UILabel {
        return getAgeLimitUseCase.getLabel(ageLimit: movie.age)
    }

    func getGenresListFromTags() -> [String] {
        return getGenresListFromTagsUseCase.getList(movie.tags)
    }

}
