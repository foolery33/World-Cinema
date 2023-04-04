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
    
    
    init(navigationController: UINavigationController, collectionsViewModel: CollectionsScreenViewModel) {
        self.navigationController = navigationController
        self.collectionsViewModel = collectionsViewModel
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
    
}
