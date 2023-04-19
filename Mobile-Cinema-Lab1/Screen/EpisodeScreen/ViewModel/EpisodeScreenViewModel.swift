//
//  EpisodeViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation

final class EpisodeScreenViewModel {
    
    weak var coordinator: MovieToEpisodeNavigationProtocol!
    var movie: MovieModel!
    var yearRange: String?
    private var model = EpisodeScreenModel()
    private var collectionsRepository: CollectionsRepository
    private var episodesRepository: EpisodesRepository
    private var collectionsDatabase: CollectionsDatabase
    
    init(collectionsRepository: CollectionsRepository, episodesRepository: EpisodesRepository, collectionsDatabase: CollectionsDatabase) {
        self.collectionsRepository = collectionsRepository
        self.episodesRepository = episodesRepository
        self.collectionsDatabase = collectionsDatabase
    }
    
    var error: String = ""
    
    var episode: EpisodeModel {
        get {
            model.episode
        }
        set {
            model.episode = newValue
        }
    }
    
    var episodeTime: EpisodeTimeModel {
        get {
            model.episodeTime
        }
        set {
            model.episodeTime = newValue
        }
    }
    
    func backToMovieScreen() {
        let coordinator = self.coordinator as! Coordinator
        coordinator.navigationController.popViewController(animated: true)
    }
    
    func getCollectionsList() -> [MovieCollection] {
        return collectionsDatabase.getAllCollections()
    }
    
    func addToCollection(collectionId: String, movieId: String, completion: @escaping (Bool) -> Void) {
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
    
    func saveEpisodeTime(episodeId: String, timeInSeconds: Int, completion: @escaping (Bool) -> Void) {
        episodesRepository.saveEpisodeTime(episodeId: episodeId, timeInSeconds: timeInSeconds) { [weak self] result in
            switch result {
            case .success:
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
    func getEpisodeTime(episodeId: String, completion: @escaping (Bool) -> Void) {
        episodesRepository.getEpisodeTime(episodeId: episodeId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.episodeTime = data
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
    }
    
}
