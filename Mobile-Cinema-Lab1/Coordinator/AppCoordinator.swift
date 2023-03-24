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
        goToAuth()
    }
    
    func goToAuth() {
        let authCoordinator = AuthCoordinator(navigationController: self.navigationController, loginViewModel: LoginScreenViewModel(), registerViewModel: RegisterScreenViewModel())
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
}
