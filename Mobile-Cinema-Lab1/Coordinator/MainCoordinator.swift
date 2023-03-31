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
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel, movieViewModel: MovieScreenViewModel) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
        self.movieViewModel = movieViewModel
    }
    
    func start() {
        goToMainScreen()
//        goToMovieScreen(movie: MovieModel(movieId: "", name: "", description: "", age: "", chatInfo: ChatModel(chatId: "", chatName: ""), imageUrls: [], poster: "", tags: []))
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
    
}
