//
//  CompilationCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 10.04.2023.
//

import UIKit

final class CompilationCoordinator: Coordinator, MovieToEpisodeNavigationProtocol {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    private var compilationViewModel: CompilationScreenViewModel
    private var movieViewModel: MovieScreenViewModel
    private var episodeViewModel: EpisodeScreenViewModel
    
    init(navigationController: UINavigationController, compilationViewModel: CompilationScreenViewModel, movieViewModel: MovieScreenViewModel, episodeViewModel: EpisodeScreenViewModel) {
        self.navigationController = navigationController
        self.compilationViewModel = compilationViewModel
        self.movieViewModel = movieViewModel
        self.episodeViewModel = episodeViewModel
    }
    
    func start() {
        goToCompilationScreen()
    }
    
    func goToCompilationScreen() {
        let compilationViewController = CompilationScreenViewController()
        self.compilationViewModel.coordinator = self
        compilationViewController.viewModel = self.compilationViewModel
        navigationController.pushViewController(compilationViewController, animated: true)
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
