//
//  AppCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        goToLoginScreen()
    }
    
    func goToLoginScreen() {
        let loginViewController = LoginViewController()
        let loginViewModel = LoginScreenViewModel()
        loginViewModel.coordinator = self
        loginViewController.viewModel = loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
}
