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
        if(TokenManager.shared.fetchAccessToken().isEmpty) {
            goToAuth()
        }
        else {
            goToMain()
        }
    }
    
    func goToAuth() {
        let authCoordinator = AuthCoordinator(navigationController: self.navigationController, loginViewModel: LoginScreenViewModel(authRepository: AuthRepositoryImplementation()), registerViewModel: RegisterScreenViewModel(authRepository: AuthRepositoryImplementation()))
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToMain() {
        let homeCoordinator = MainTabBarCoordinator(navigationController: self.navigationController, mainViewModel: MainScreenViewModel(coverRepository: CoverRepositoryImplementation()))
        children.append(homeCoordinator)
        homeCoordinator.parentCoordinator = self
        homeCoordinator.start()
    }
    
}
