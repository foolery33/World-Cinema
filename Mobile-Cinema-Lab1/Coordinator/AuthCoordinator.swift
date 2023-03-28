//
//  LoginCoordinator.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 24.03.2023.
//

import Foundation
import UIKit

class AuthCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: ViewModels
    var loginViewModel: LoginScreenViewModel
    var registerViewModel: RegisterScreenViewModel
    
    init(navigationController: UINavigationController, loginViewModel: LoginScreenViewModel, registerViewModel: RegisterScreenViewModel) {
        self.navigationController = navigationController
        self.loginViewModel = loginViewModel
        self.registerViewModel = registerViewModel
        print(self.loginViewModel.email)
    }
    
    func start() {
        if((UserDefaults.standard.value(forKey: "firstLaunch")) != nil) {
            goToLoginScreen()
        }
        else {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            goToRegisterScreen()
        }
    }
    
    func goToLoginScreen() {
        let loginViewController = LoginViewController()
        self.loginViewModel.coordinator = self
        loginViewController.viewModel = self.loginViewModel
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func goToRegisterScreen() {
        if((UserDefaults.standard.value(forKey: "firstLaunch")) != nil) {
            let loginViewController = LoginViewController()
            self.loginViewModel.coordinator = self
            loginViewController.viewModel = self.loginViewModel
            navigationController.pushViewController(loginViewController, animated: false)
        }
        let registerViewController = RegisterViewController()
        self.registerViewModel.coordinator = self
        registerViewController.viewModel = self.registerViewModel
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func goToMainScreen() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToMain()
        parentCoordinator?.childDidFinish(self)
    }
    
}
