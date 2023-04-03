//
//  MainCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 25.03.2023.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    var mainViewModel: MainScreenViewModel
    var movieViewModel: MovieScreenViewModel
    var episodeViewModel: EpisodeScreenViewModel
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel, movieViewModel: MovieScreenViewModel, episodeViewModel: EpisodeScreenViewModel) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
        self.movieViewModel = movieViewModel
        self.episodeViewModel = episodeViewModel
    }
    
    func start() {
        goToMainScreen()
    }
    
    func goToMainScreen() {
        let mainViewController = MainScreenViewController()
        self.mainViewModel.coordinator = self
        mainViewController.viewModel = self.mainViewModel
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func goToMovieScreen(movie: MovieModel) {
        let movieViewController = MovieScreenViewController()
        self.movieViewModel.coordinator = self
        movieViewModel.movie = movie
        movieViewController.viewModel = self.movieViewModel
        navigationController.pushViewController(movieViewController, animated: true)
    }
    
    func goToEpisodeScreen(yearRange: String, episode: EpisodeModel, movie: MovieModel) {
        let episodeViewController = EpisodeScreenViewController()
        self.episodeViewModel.coordinator = self
        episodeViewModel.episode = episode
        episodeViewModel.movie = movie
        episodeViewModel.yearRange = yearRange
        episodeViewController.viewModel = self.episodeViewModel
        navigationController.pushViewController(episodeViewController, animated: true)
    }
    
}
