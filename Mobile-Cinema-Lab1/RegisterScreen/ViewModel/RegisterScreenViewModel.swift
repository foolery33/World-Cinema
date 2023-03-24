//
//  RegisterScreenViewModel.swift
//  Mobile-Cinema-Lab1
//
//  Created by admin on 23.03.2023.
//

import Foundation

class RegisterScreenViewModel {
    
    private var model = RegisterScreenModel()
    weak var coordinator: AuthCoordinator!
    
    var name: String {
        get {
            model.name
        }
        set {
            model.name = newValue
        }
    }
    
    var surname: String {
        get {
            model.surname
        }
        set {
            model.surname = newValue
        }
    }
    
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
    
    var confirmPassword: String {
        get {
            model.confirmPassword
        }
        set {
            model.confirmPassword = newValue
        }
    }

    func loginButtonTapped() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
}
