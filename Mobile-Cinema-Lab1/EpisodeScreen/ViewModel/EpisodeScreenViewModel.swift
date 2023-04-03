//
//  EpisodeViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 02.04.2023.
//

import Foundation

final class EpisodeScreenViewModel {
    
    weak var coordinator: MainCoordinator!
    var movie: MovieModel!
    var yearRange: String?
    private var model = EpisodeScreenModel()
    
    var episode: EpisodeModel {
        get {
            model.episode
        }
        set {
            model.episode = newValue
        }
    }
    
    func backToMovieScreen() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
}
