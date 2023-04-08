//
//  CollectionsCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 04.04.2023.
//

import UIKit

final class CollectionsCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    var collectionsViewModel: CollectionsScreenViewModel
    var createCollectionViewModel: CreateCollectionScreenViewModel
    
    init(navigationController: UINavigationController, collectionsViewModel: CollectionsScreenViewModel, createCollectionViewModel: CreateCollectionScreenViewModel) {
        self.navigationController = navigationController
        self.collectionsViewModel = collectionsViewModel
        self.createCollectionViewModel = createCollectionViewModel
    }
    
    func start() {
        goToCollectionsScreen()
    }
    
    func goToCollectionsScreen() {
        let collectionsViewController = CollectionsScreenViewController()
        self.collectionsViewModel.coordinator = self
        collectionsViewController.viewModel = self.collectionsViewModel
        navigationController.pushViewController(collectionsViewController, animated: true)
    }
    
    func goToCreateCollectionScreen() {
        let createCollectionViewController = CreateCollectionScreenViewController()
        self.createCollectionViewModel.coordinator = self
        createCollectionViewController.viewModel = self.createCollectionViewModel
        self.collectionsViewModel.startListeningForChanges(on: createCollectionViewModel)
        navigationController.pushViewController(createCollectionViewController, animated: true)
    }
    
}
