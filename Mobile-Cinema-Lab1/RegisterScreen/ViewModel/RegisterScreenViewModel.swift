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
    
    var error: String {
        get {
            model.error
        }
        set {
            model.error = newValue
        }
    }
    
    func loginButtonTapped() {
        coordinator.navigationController.popViewController(animated: true)
    }
    
    func register(completion: @escaping (Bool) -> Void) {
        
        // MARK: Empty fields validation
        if(EmptyFieldValidation().isEmptyField(name) ||
           EmptyFieldValidation().isEmptyField(surname) ||
           EmptyFieldValidation().isEmptyField(email) ||
           EmptyFieldValidation().isEmptyField(password) ||
           EmptyFieldValidation().isEmptyField(confirmPassword)) {
            self.error = AppError.authError(.emptyField).errorDescription
            completion(false)
            return
        }
        
        // MARK: Passwords equality validation
        if(!PasswordsEquality().areEqualPasswords(password, confirmPassword)) {
            self.error = AppError.authError(.differentPasswords).errorDescription
            completion(false)
            return
        }
        
        // MARK: Email pattern validation
        if(!EmailValidation().isValidEmail(email)) {
            self.error = AppError.authError(.invalidEmail).errorDescription
            completion(false)
            return
        }
        
        AuthViewModel.shared.register(email: email, password: password, firstName: name, lastName: surname) { [weak self] result in
            switch result {
            case .success(let data):
                TokenManager.shared.saveAccessToken(accessToken: data.accessToken)
                TokenManager.shared.saveRefreshToken(refreshToken: data.refreshToken)
                completion(true)
            case .failure(let error):
                self?.error = error.errorDescription
                completion(false)
            }
        }
        
    }
    
}
