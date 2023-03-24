//
//  LoginScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation

class LoginScreenViewModel {
    
    private var model: LoginScreenModel = LoginScreenModel()
    weak var coordinator: AuthCoordinator!
    
    var email: String {
        get {
            model.email
        }
        set {
            model.email = newValue
        }
    }
    
    var password: String {
        get {
            model.password
        }
        set {
            model.password = newValue
        }
    }
    
    func registerButtonTapped() {
        coordinator.goToRegisterScreen()
    }
    
}
