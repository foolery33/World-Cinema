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
    
    init(navigationController: UINavigationController, mainViewModel: MainScreenViewModel) {
        self.navigationController = navigationController
        self.mainViewModel = mainViewModel
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
    
}
