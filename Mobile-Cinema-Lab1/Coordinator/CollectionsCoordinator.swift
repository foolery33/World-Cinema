//
//  CollectionsCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit

final class CollectionsCoordinator: Coordinator, MovieToEpisodeNavigationProtocol {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    private var collectionsViewModel: CollectionsScreenViewModel
    private var collectionViewModel: CollectionScreenViewModel
    private var createCollectionViewModel: CreateCollectionScreenViewModel
    private var movieViewModel: MovieScreenViewModel
    private var episodeViewModel: EpisodeScreenViewModel

    init(navigationController: UINavigationController, collectionsViewModel: CollectionsScreenViewModel, collectionViewModel: CollectionScreenViewModel, createCollectionViewModel: CreateCollectionScreenViewModel, movieViewModel: MovieScreenViewModel, episodeViewModel: EpisodeScreenViewModel) {
        self.navigationController = navigationController
        self.collectionsViewModel = collectionsViewModel
        self.collectionViewModel = collectionViewModel
        self.createCollectionViewModel = createCollectionViewModel
        self.movieViewModel = movieViewModel
        self.episodeViewModel = episodeViewModel
    }
  
//    init(navigationController: UINavigationController, collectionsViewModel: CollectionsScreenViewModel, collectionViewModel: CollectionScreenViewModel, createCollectionViewModel: CreateCollectionScreenViewModel) {
//        self.navigationController = navigationController
//        self.collectionsViewModel = collectionsViewModel
//        self.collectionViewModel = collectionViewModel
//        self.createCollectionViewModel = createCollectionViewModel
//    }
    
    func start() {
        goToCollectionsScreen()
    }
    
    func goToCollectionsScreen() {
        let collectionsViewController = CollectionsScreenViewController()
        self.collectionsViewModel.coordinator = self
        collectionsViewController.viewModel = self.collectionsViewModel
        navigationController.pushViewController(collectionsViewController, animated: true)
    }
    
    func goToCollectionScreen(collection: CollectionModel) {
        let collectionViewController = CollectionScreenViewController()
        self.collectionViewModel.coordinator = self
        self.collectionViewModel.collection = collection
        collectionViewController.viewModel = self.collectionViewModel
        navigationController.pushViewController(collectionViewController, animated: true)
    }
    
    func goToCreateCollectionScreen() {
        let createCollectionViewController = CreateCollectionScreenViewController()
        self.createCollectionViewModel.coordinator = self
        createCollectionViewController.viewModel = self.createCollectionViewModel
        self.collectionsViewModel.startListeningForChanges(on: createCollectionViewModel)
        navigationController.pushViewController(createCollectionViewController, animated: true)
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
