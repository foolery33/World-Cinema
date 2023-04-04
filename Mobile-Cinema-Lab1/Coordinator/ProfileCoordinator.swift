//
//  ProfileCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 03.04.2023.
//

import UIKit

final class ProfileCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModel
    var profileViewModel: ProfileScreenViewModel
    
    init(navigationController: UINavigationController, profileViewModel: ProfileScreenViewModel) {
        self.navigationController = navigationController
        self.profileViewModel = profileViewModel
    }
    
    func start() {
        goToProfileScreen()
    }
    
    private func goToProfileScreen() {
        var profileViewController = ProfileScreenViewController()
        self.profileViewModel.coordinator = self
        profileViewController.viewModel = self.profileViewModel
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func goToLoginScreen() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToAuth()
        parentCoordinator?.childDidFinish(self)
    }
    
}
